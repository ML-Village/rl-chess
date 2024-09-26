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
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import {
  ToggleGroup,
  ToggleGroupItem,
} from "@/components/ui/toggle-group"

import { feltToString, stringToFelt } from "@/utils/starknet";
import { format } from 'path';

export const InviteGameModal: React.FC = () => {

  const {
    setup: {
      clientComponents: { Player, Format },
      client,
  },
    account: {account},
  } = useDojo();

  const { open, setOpen } = useInviteGameModalStore();
  const [selectedFormatNum, setSelectedFormatNum] = useState<string>("7");

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
  const [expiryTime, setExpiryTime] = useState(1);
  const handleCreateGame = (config: any) => {
    console.log("Create game", config);
  }

  const handleInviteOpponent = async () => {
    // console.log("Invite opponent", opponentAddress);
    // console.log("Expiry time", expiryTime);
    // console.log("Selected Config", 
    //   import.meta.env.VITE_USE_CONTRACT_GAME_FORMATS === "true" ?
    //     formats[Number(selectedFormatNum)] : gameConfigsWithCategories[Number(selectedFormatNum)]
    //   )

    console.log("Invite opponent", opponentAddress, "format", selectedFormatNum, "expiry", expiryTime);
    
    await client.lobby.create_invite_game({
      account: account,
      game_format_id: Number(selectedFormatNum),
      invitee_address: BigInt(opponentAddress),
      invite_expiry: expiryTime * 3600,
    })
    setOpen(false);
  }


  const gameConfigsWithCategories = Object.entries(gameFormatconfig).map(([_, value]) => {
    return {
      ...value,
      category: value?.description?.split("-")[0]
    };
  })

  console.log("Selected format", selectedFormatNum);

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

        {/* Address Input */}
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

        <ToggleGroup
          className="w-full flex flex-col justify-center items-start space-y-0
          "
          variant="outline"

          type="single"
          defaultValue={selectedFormatNum}
          onValueChange={(value) => {
            //console.log("Selected format", value);
            setSelectedFormatNum(value);
          }}
          
          >
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
                                <ToggleGroupItem key={`gameformat-${config?.format_id??index}`}
                                  className="bg-blue-400/50 text-gray-800/80 px-4 py-2 rounded-md
                                  grow
                                  data-[state=on]:bg-blue-900 data-[state=on]:text-white
                                  "
                                  value={config.format_id?.toString()??index.toString()}
                                  >
                                  {config.total_time_string}
                                </ToggleGroupItem>
                            )
                          })
                          :
                          gameConfigsWithCategories.filter((config) => config.category === category).map((config, index) => {
                            return (
                                <ToggleGroupItem key={`gameformat-${config?.format_id??index}`}
                                  className="px-4 py-2 rounded-md
                                  grow
                                  data-[state=on]:bg-orange-500 data-[state=on]:text-white
                                  "
                                  value={config.format_id??index.toString()}
                                  >
                                  {config.total_time_string}
                                </ToggleGroupItem>
                            )
                          })
                        }
                        </div>
                      </div>
                  )
              })
            }
        </ToggleGroup>
      </DialogContent>
    </Dialog>
  );
};