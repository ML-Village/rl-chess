import React from 'react';
import { Button } from '@/components/ui/button';

// Dojo stuff
import { useDojo } from "@/dojo/useDojo";
import { useComponentValue, useEntityQuery } from "@dojoengine/react";
import { Entity, Has, HasValue, getComponentValueStrict, getComponentValue } from "@dojoengine/recs";
import { getEntityIdFromKeys } from "@dojoengine/utils";

import { entityIdToKey, bigintToEntity, keysToEntity, bigintToHex,
    getPlayerName, getPlayerPfPurlByNum
} from '@/utils';

export const GameRoomControls = ({roomId}:{roomId:string}) => {

    const {
        setup: {
            clientComponents: { Game, Player },
            client
        },
        account: {account}
    } = useDojo();

    const entityId = getEntityIdFromKeys([
        BigInt(roomId??""),
    ]) as Entity;

    const gameObject = useComponentValue(Game, entityId);
    const gameStarted = gameObject?.game_state == "InProgress";
    const playerInGame = bigintToHex(gameObject?.room_owner_address??0n) == account.address || bigintToHex(gameObject?.invitee_address??0n) == account.address;
    const playerIsOwner = bigintToHex(gameObject?.room_owner_address??0n) == account.address;
    const playerIsInvitee = bigintToHex(gameObject?.invitee_address??0n) == account.address;

    const playerIsReady = playerInGame ? (playerIsOwner ? gameObject?.owner_ready??false : gameObject?.invitee_ready??false) : false;
    const ownerIsReady = gameObject?.owner_ready??false;
    const inviteeIsReady = gameObject?.invitee_ready??false;
    const everyoneIsReady = ownerIsReady && inviteeIsReady;

    console.log("GameRoomControls: Owner is Ready", gameObject?.owner_ready)
    console.log("GameRoomControls: Invitee is Ready", gameObject?.invitee_ready)
    return (
        <div className="flex justify-start items-center gap-x-1
        w-full mx-2 px-6
        ">
            <button className={`py-3 rounded-lg font-semibold
                    ${
                        gameObject?.game_state == "Awaiting" ? "bg-yellow-300" :
                        gameObject?.game_state == "Accepted" ? "bg-orange-400" :
                        gameObject?.game_state == "InProgress" ? "bg-green-500":
                        gameObject?.game_state == "Resolved" ? "bg-blue-900/80":
                        "bg-purple-800/80"
                    }
                    text-blue-950 text-xs 2xl:text-sm
                    px-1 xl:px-2 2xl:px-2
                    `}
                    disabled={true}
                    >
                Game: {gameObject?.game_state}
            </button>
            {playerInGame ?
                <>{
                    !gameStarted ?
                    <>
                        <Button className="py-5 rounded-lg bg-purple-300/80
                        text-blue-950 hover:text-white text-xs 2xl:text-sm
                        px-1 xl:px-2 2xl:px-2
                        "
                        onClick={async ()=>{
                            await client.lobby.switch_sides({account, game_id: BigInt(roomId??0)})
                        }}
                        >
                            Switch Sides
                        </Button>

                        <Button className={`py-5 rounded-lg 
                        ${playerIsReady ?"bg-green-400": "bg-orange-400"}
                        text-blue-950 hover:text-white text-xs 2xl:text-sm
                        px-1 xl:px-2 2xl:px-2
                        `}

                        onClick={async()=>{
                            await client.lobby.ready_up({account, game_id: BigInt(roomId??0)})
                        }}
                        disabled={playerIsReady}
                        >
                            Ready Up
                        </Button>
                        <Button className="py-5 rounded-lg bg-orange-400
                        text-blue-950 hover:text-white text-xs 2xl:text-sm
                        px-1 xl:px-2 2xl:px-2
                        "

                        onClick={async()=>{
                            await client.lobby.start_game({account, game_id: BigInt(roomId??0)})
                        }}
                        disabled={!everyoneIsReady}
                        >
                            Start Game
                        </Button>
                        
                    </>
                    :
                    null
                }

                {gameStarted ?
                <>  
                    
                    <Button className="py-5 rounded-lg bg-orange-400
                    text-blue-950 hover:text-white text-xs 2xl:text-sm
                    px-1 xl:px-2 2xl:px-2
                    ">
                        Offer Draw
                    </Button>
                    <Button className="py-5 rounded-lg bg-orange-400
                    text-blue-950 hover:text-white text-xs 2xl:text-sm
                    px-1 xl:px-2 2xl:px-2
                    ">
                        Resign
                    </Button>
                </>
                :
                null
                }
                </>
                :
                <></>
            }
        </div>
    )
}
