import React, { useEffect, useState, useCallback } from 'react';

import { useDojo } from "@/dojo/useDojo";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import { useComponentValue, useEntityQuery } from "@dojoengine/react";
import { Entity, Has, HasValue, getComponentValueStrict, getComponentValue } from "@dojoengine/recs";

import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";

import { useInviteGameModalStore } from '@/store';
import { gameFormatconfig, gameCategoryOrder } from "@/constants";
import { GiBulletBill, GiLightningTrio } from "react-icons/gi";
import { BiSolidTimer } from "react-icons/bi";
import { WiDayLightWind } from "react-icons/wi";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";

import { feltToString, stringToFelt } from "@/utils/starknet";

export const InviteGameModal: React.FC = () => {

  const {
    setup: {
      clientComponents: { Player, Format },
      client,
  },
    account: {account},
  } = useDojo();

  const { open, setOpen } = useInviteGameModalStore();

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

  const [opponentAddress, setOpponentAddress] = useState("");

  const handleCreateGame = (config: any) => {
    console.log("Create game", config);
  }

  const handleInviteOpponent = () => {
    console.log("Invite opponent", opponentAddress);
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
          <DialogTitle>Create Invite to Game</DialogTitle>
          <DialogDescription>
            Create a new game in the lobby and invite an opponent to join.
            Game expires as set.
          </DialogDescription>
        </DialogHeader>
        <div className="flex gap-x-2">
          {/* //ring should be orange */}
          <Input
            className="grow focus-visible:ring-orange-500
            "
            placeholder="Enter Invitee address"
            value={opponentAddress}
            onChange={(e) => setOpponentAddress(e.target.value)}
          />
          <Button className="bg-orange-600"
          onClick={handleInviteOpponent}>Invite
          </Button>
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