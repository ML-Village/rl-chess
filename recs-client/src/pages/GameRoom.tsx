import React, {useState, useMemo} from 'react';
import { useComponentValue, useEntityQuery } from "@dojoengine/react";
import { Entity, Has, HasValue, getComponentValueStrict, getComponentValue } from "@dojoengine/recs";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import { useDojo } from "@/dojo/useDojo";
import { Chessboard } from 'react-chessboard';
import { Chess } from 'chess.js';
import { entityIdToKey, bigintToEntity, keysToEntity, bigintToHex,

    getPlayerName, getPlayerPfPurlByNum
} from '@/utils';

import { useParams } from 'react-router-dom';
import { feltToString, stringToFelt } from "@/utils/starknet";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { useNamePanel } from '@/hooks';
import { Button } from '@/components/ui/button';
import { PlayerPanel, RoomColumn } from '@/components/GameRoom';


export const GameRoom = () => {
    const { roomId } = useParams();
    const {
        setup: {
            clientComponents: { Game, Player },
            client
        },
        account:{account},
    } = useDojo();

    const [game, setGame] = useState(new Chess());
    const onDrop = (sourceSquare: string, targetSquare: string) => {

        const move = game.move({
            from: sourceSquare,
            to: targetSquare,
            promotion: 'q',
        });
        console.log("GameRoom: Game Fen - ")
        console.log(game.fen())
        if (move === null) return false;
        setGame(new Chess(game.fen()));
        return true
    }

    console.log("room Id: ", roomId)
    const entityId = getEntityIdFromKeys([
        BigInt(roomId??""),
    ]) as Entity;

    const gameObject = useComponentValue(Game, entityId);
    //console.log("GameRoom: gameObject", gameObject)

    const playerInGame = bigintToHex(gameObject?.room_owner_address??0n) == account.address || bigintToHex(gameObject?.invitee_address??0n) == account.address;
    const playerIsOwner = bigintToHex(gameObject?.room_owner_address??0n) == account.address;
    const playerIsInvitee = bigintToHex(gameObject?.invitee_address??0n) == account.address;
    const playerColor = playerInGame ? bigintToHex(gameObject?.white_player_address??0n) == account.address ? "white" : "black" : undefined;
    
    // console.log("GameRoom: player address", account.address)
    // console.log("GameRoom: room_owner_address", bigintToHex(gameObject?.room_owner_address??0n))
    // console.log("GameRoom: invitee address", bigintToHex(gameObject?.invitee_address??0n))
    // console.log("GameRoom: white_player_address", bigintToHex(gameObject?.white_player_address??0n))
    // console.log("GameRoom: black_player_address", bigintToHex(gameObject?.black_player_address??0n))
    const ownerIsWhite = gameObject?.white_player_address == gameObject?.room_owner_address;
    const ownerColor = ownerIsWhite ? "white" : "black";
    
    // Player Stuff
    const playerEntity = bigintToEntity(
        account.address??0n
    ) as Entity;
    const playerPlayerObject = useComponentValue(Player, playerEntity);
    const playerName = getPlayerName(playerPlayerObject);
    const playerPfPurl = getPlayerPfPurlByNum(playerPlayerObject?.profile_pic_uri??0);
    const playerTimeRemaining = 0;

    // Owner Stuff
    const ownerEntity = bigintToEntity(
        gameObject?.room_owner_address??0n
    ) as Entity;
    const ownerPlayerObject = useComponentValue(Player, ownerEntity);
    const ownerName = getPlayerName(ownerPlayerObject);
    const ownerPfPurl = getPlayerPfPurlByNum(ownerPlayerObject?.profile_pic_uri??0);
    const ownerLastMoveTime = (ownerIsWhite ? gameObject?.w_last_move_time : gameObject?.b_last_move_time)??0;
    const ownerTimeRemaining = (ownerIsWhite ? gameObject?.w_total_time_left : gameObject?.b_total_time_left)??0;
    const ownerReady = gameObject?.owner_ready;

    // Invitee Stuff
    const inviteeAddressBigInt = gameObject?.invitee_address;
    const inviteeNotNull = Number(inviteeAddressBigInt) == 0 ? false : true;
    const inviteeEntity: Entity = inviteeNotNull ? bigintToEntity(
        gameObject?.invitee_address??0n,
    ) : "0x0" as Entity;

    const inviteePlayerObject = useComponentValue(Player, inviteeEntity);
    const inviteeName = inviteeNotNull ? getPlayerName(inviteePlayerObject): "";
    const inviteePfPurl = inviteeNotNull ? getPlayerPfPurlByNum(inviteePlayerObject?.profile_pic_uri??0) : "";
    const inviteeLastMoveTime = (ownerIsWhite ? gameObject?.b_last_move_time : gameObject?.w_last_move_time)??0;
    const inviteeTimeRemaining = (ownerIsWhite ? gameObject?.b_total_time_left : gameObject?.w_total_time_left)??0;
    const inviteeReady = gameObject?.invitee_ready;

    // console.log("GameRoom: invitee address: ", gameObject?.invitee_address)
    // console.log("GameRoom: invitee entity: ", inviteeEntity)

    const ownerNamePanel = useNamePanel({ownerName, ownerPfPurl});
    const inviteeNamePanel = useNamePanel({ownerName: inviteeName, ownerPfPurl: inviteePfPurl});

    const handleJoinGame = async() => {
        console.log("GameRoom: Joining Game...")
        if(roomId && roomId != "0"){
            await client.lobby.join_game({
                account: account,
                game_id: BigInt(roomId??0),
            })
        }
    }

    //console.log("GameRoom: Player Color:", playerColor)
    return (
        <div className="flex justify-center items-start
        ">
            <div className="flex justify-center items-center gap-x-2
            h-[90vh] p-2 pr-4
            border border-green-600
            ">

                {/* Chessboard column */}
                <div className="flex flex-col
                justify-center items-center h-[88vh] w-[30vw]
                border border-purple-500
                ">

                    {inviteeNotNull ? 
                        <PlayerPanel ownerNamePanel={
                            playerInGame ?  
                            (playerIsOwner ? inviteeNamePanel : ownerNamePanel)
                            : inviteeNamePanel
                        } 
                        
                        ownerTimeRemaining={playerInGame ?
                            (playerIsOwner ?  String(inviteeTimeRemaining) : String(ownerTimeRemaining))
                            :
                            String(inviteeTimeRemaining)
                        } 
                        ownerLastMoveTime={playerInGame ?
                            (playerIsOwner ?  String(inviteeLastMoveTime) : String(ownerLastMoveTime))
                            :
                            String(inviteeLastMoveTime)
                        }
                        ready={(playerInGame ?
                            (playerIsOwner ? inviteeReady : ownerReady)
                            : inviteeReady)??false}
                        
                        game_state={gameObject?.game_state ?? ""}
                        /> :
                        
                    <div className="w-full p-3 flex items-center
                        ">
                        <Button className="bg-orange-600"
                        onClick={handleJoinGame}
                        >
                            Join Game
                        </Button>
                    </div>
                    }
                    

                    <div className="w-4/5 m-2 my-4
                    border-2 border-blue-900/80 rounded-lg
                        ">
                        <Chessboard 
                            position={game.fen()} 
                            onPieceDrop={onDrop}
                            boardOrientation={
                                playerInGame ?
                                (playerColor??"white")
                                :ownerColor??"white"
                            }
                            customDarkSquareStyle={{
                                backgroundColor: "#779952"
                            }} customLightSquareStyle={{
                                backgroundColor: "#edeed1"
                            }} 
                        />
                    </div>
                    

                    <PlayerPanel ownerNamePanel={playerInGame ?  
                    (playerIsOwner ? ownerNamePanel : inviteeNamePanel)
                    : ownerNamePanel} 
                        ownerTimeRemaining={playerInGame ?  
                            (playerIsOwner ? String(ownerTimeRemaining) : String(inviteeTimeRemaining))
                            : String(ownerTimeRemaining)} 

                        ownerLastMoveTime={playerInGame ?
                            (playerIsOwner ?  String(ownerLastMoveTime) : String(inviteeLastMoveTime))
                                :
                                String(ownerLastMoveTime)
                            }
                        ready={(playerInGame ?
                            (playerIsOwner ? ownerReady : inviteeReady)
                            : ownerReady)??false}
                        game_state={gameObject?.game_state ?? ""}
                    />

                </div>

                {/* Chat column */}
                <RoomColumn roomId={roomId??""} ownerName={ownerName} inviteeName={inviteeName} />

            </div>
        </div>
    )
}
