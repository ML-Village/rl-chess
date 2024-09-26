import React, { useEffect, useState, useCallback } from 'react';

import { useDojo } from "@/dojo/useDojo";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import { useComponentValue, useEntityQuery } from "@dojoengine/react";
import { Entity, Has, HasValue, getComponentValueStrict, getComponentValue } from "@dojoengine/recs";

import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";

import { useNewGameModalStore } from '@/store';
import { gameFormatconfig, gameCategoryOrder } from "@/constants";
import { GiBulletBill, GiLightningTrio } from "react-icons/gi";
import { BiSolidTimer } from "react-icons/bi";
import { WiDayLightWind } from "react-icons/wi";

import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { feltToString, stringToFelt } from "@/utils/starknet";

export const CreateGameModal: React.FC = () => {

  const {
    setup: {
      clientComponents: { Player, Format },
      client,
  },
    account: {account},
  } = useDojo();

  const { open, setOpen } = useNewGameModalStore();
  const [expiryTime, setExpiryTime] = useState(24);

  // entity id we are syncing
  const entityId = getEntityIdFromKeys([
    BigInt(account?.address),
  ]) as Entity;

  // get current component values
  const player = useComponentValue(Player, entityId);
  const hasFormats = useEntityQuery([Has(Format)]);
  const formats = hasFormats.map((format) => {
    const f = getComponentValue(Format, format)
    return {
      ...f,
      description: feltToString(String(f?.description)),
      total_time_string: feltToString(String(f?.total_time_string)),
      category: feltToString(String(f?.description))?.split("-")[0]??""
    }
  }).sort((a, b) => (a.format_id ?? 0) - (b.format_id ?? 0));

  const handleCreateGame = async (config) => {
    //console.log("LobbyControls: creating game");
    //console.log(config)
    if (account) {
        try{
            //await create_game(account.account as AccountInterface, 1);
            await client.lobby.create_game({
                account,
                game_format_id: config.format_id??1,
                invite_expiry: expiryTime*3600, // 1 day
            });
            setOpen(false);
        }catch(e){
            console.log("error creating game: ", e);
        }
    }else{
        console.log("account not connected");
        //todo: make toast for error message
    }
  } 

  const gameConfigsWithCategories = Object.entries(gameFormatconfig).map(([_, value]) => {
    return {
      ...value,
      category: value?.description?.split("-")[0]
    };
  })

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogContent className="sm:max-w-[425px]
      flex flex-col justify-center space-y-0
      ">
        
        <DialogHeader>
          <DialogTitle>Create A New Game</DialogTitle>
          <DialogDescription>
            Create a new game in the lobby and wait for an opponent to join.
            Game expires as set.
          </DialogDescription>
        </DialogHeader>

        {/* Expiry Time (Hours) */}
        <div className="flex items-center gap-x-2">
          <Label className="flex-1">Expiry Time (Hours)</Label>
          <Input
            name="expiry_time"
            type="number"
            className="w-2/5 focus-visible:ring-orange-500
            text-center
            "
            min={1}
            max={72}
            value={expiryTime}
            onChange={(e) => setExpiryTime(Number(e.target.value))}
          />
        </div>
        
          {
            gameCategoryOrder.map((category) => {
              return (
                  <div key={`category-${category}`}>
                    <div className="w-full py-1 px-2
                    flex justify-start items-center gap-x-1
                    ">
                      {category=="Daily"? <WiDayLightWind /> :
                      category=="Rapid"? <BiSolidTimer/> :
                      category=="Blitz"? <GiLightningTrio /> :
                      category=="Bullet"? <GiBulletBill /> :
                      null
                    }{category}</div>
                    <div className="flex w-full gap-1 flex-wrap p-1
                    justify-center items-center
                    ">
                      {
                        import.meta.env.VITE_USE_CONTRACT_GAME_FORMATS=="true"?
                        formats.filter((config) => config.category === category).map((config, index) => {
                          return (
                              <button key={`gameformat-${config?.format_id??index}`}
                                className="bg-blue-900 text-white px-4 py-2 rounded-md
                                grow
                                hover:bg-blue-400
                                "
                                onClick={()=>handleCreateGame(config)}
                                >
                                {config.total_time_string}
                              </button>
                          )
                        })
                        :
                        gameConfigsWithCategories.filter((config) => config.category === category).map((config, index) => {
                          return (
                              <button key={`gameformat-${config?.format_id??index}`}
                                className="bg-blue-900 text-white px-4 py-2 rounded-md
                                grow
                                hover:bg-blue-400
                                "
                                onClick={()=>handleCreateGame(config)}
                                >
                                {config.total_time_string}
                              </button>
                          )
                        })
                      }
                      </div>
                    </div>
                )
            })
          }
      </DialogContent>
    </Dialog>
  );
};