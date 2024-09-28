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

import { FaChessKnight } from "react-icons/fa6";

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
    const gameAccepted = gameObject?.game_state == "Accepted";
    const gameStarted = gameObject?.game_state == "InProgress";
    const playerInGame = bigintToHex(gameObject?.room_owner_address??0n) == account.address || bigintToHex(gameObject?.invitee_address??0n) == account.address;
    const playerIsOwner = bigintToHex(gameObject?.room_owner_address??0n) == account.address;
    const playerIsInvitee = bigintToHex(gameObject?.invitee_address??0n) == account.address;

    const playerIsReady = playerInGame ? (playerIsOwner ? gameObject?.owner_ready??false : gameObject?.invitee_ready??false) : false;
    const ownerIsReady = gameObject?.owner_ready??false;
    const inviteeIsReady = gameObject?.invitee_ready??false;
    const everyoneIsReady = ownerIsReady && inviteeIsReady;

    const winner = useComponentValue(Player, 
        getEntityIdFromKeys([
            gameObject?.winner,
        ])
    );
    const winnerName = getPlayerName(winner);

    const handleAcceptInvite = async () => {
        await client.lobby.reply_invite({
            account: account,
            game_id: BigInt(roomId??0),
            accepted: true,
        })
    }

    return (
        <div className="flex justify-start items-center gap-x-1
        w-full mx-2 px-6
        ">  
            {/* Game Status Button */}
            <div className="w-full flex flex-col gap-y-1">
                <div className="w-full flex justify-start gap-x-2">
                    <button className={`py-2 rounded-lg font-semibold
                            ${
                                gameObject?.game_state == "Awaiting" ? "bg-yellow-300" :
                                gameObject?.game_state == "Accepted" ? "bg-orange-400" :
                                gameObject?.game_state == "InProgress" ? "bg-green-500":
                                gameObject?.game_state == "Resolved" ? "bg-cyan-400/80":
                                "bg-purple-800/80"
                            }
                            text-blue-950 text-xs 2xl:text-sm
                            px-1 xl:px-2 2xl:px-2
                            `}
                            disabled={true}
                            >
                        Game: {gameObject?.game_state}
                    </button>
                    {/* Invitee Accept Button */}
                    { gameObject?.game_state == "Awaiting" ?
                        
                        (
                        playerIsInvitee ?
                        <Button className="py-2 rounded-lg bg-red-500 font-semibold
                        text-white hover:text-white text-xs 2xl:text-sm
                        px-1 xl:px-2 2xl:px-2
                        grow
                        "
                        onClick={handleAcceptInvite}
                        >
                            Invitee Pls Accept Invite!!
                        </Button>
                        :
                        <Button className="py-2 rounded-lg border border-red-500
                        bg-transparent font-semibold
                        text-red-500 text-xs 2xl:text-sm
                        px-1 xl:px-2 2xl:px-2
                        hover:bg-transparent hover:cursor-default
                        grow
                        "
                        >
                            AWAITING INVITEE ACCEPTANCE
                        </Button>
                        )
                    :
                    <></>
                    }
                    {/* Results Panel */}
                    {gameObject?.game_state == "Resolved" ?
                        <div className="flex items-center gap-x-1
                        px-2 ml-auto
                        ">
                            <span className="text-sm">Winner:</span>
                            {
                                (gameObject?.result == 1 || gameObject?.result == 2) ? 
                                    (
                                        (gameObject?.winner == gameObject?.white_player_address) ?
                                        <>
                                            <span className="p-2 bg-orange-500/80 text-white rounded-full">
                                                <FaChessKnight className="bg-orange-500/80 text-white" />
                                            </span>
                                            <span className="mx-1">{winnerName}</span>
                                        </>
                                        :
                                        <>
                                            <span className="p-2 bg-lime-500 text-black rounded-full">
                                                <FaChessKnight className="bg-lime-500 text-black" />
                                            </span>
                                            <span className="mx-1">{winnerName}</span>
                                        </>
                                    )
                                : 
                                    
                                    gameObject?.result == 3 ?
                                    <span className="p-2 bg-orange-400 text-gray-800 rounded-lg">Draw</span>
                                    :
                                    <span className="p-2 bg-purple-800/80 text-white rounded-lg">Unresolved</span>
                            }
                        </div>
                        :
                        <>
                        </>
                    }
                </div>

                {/* Game Controls */}
                <div className="w-full flex gap-x-1
                
                ">
                    {playerInGame ?
                        <>

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
                        gameObject?.game_state == "Resolved" ?
                            <>
                            </>
                            :
                            <>
                                <Button className="py-5 rounded-lg bg-purple-300/80
                                text-blue-950 hover:text-white text-xs 2xl:text-sm
                                px-1 xl:px-2 2xl:px-2
                                "
                                onClick={async ()=>{
                                    await client.lobby.switch_sides({account, game_id: BigInt(roomId??0)})
                                }}
                                disabled={everyoneIsReady}
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
                                disabled={!everyoneIsReady || !gameAccepted || !playerIsOwner}
                                >
                                    Start Game
                                </Button>
                                
                            </>
                        }
                        </>

                        :
                        <></>
                    }
                </div>
            </div>
        </div>
    )
}
