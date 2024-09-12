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
import { Button } from '@/components/ui/button';
import { PlayerPanel } from '@/components/';


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

        if (move === null) return false;
        setGame(new Chess(game.fen()));
        return true
    }

    console.log("room Id: ", roomId)
    const entityId = getEntityIdFromKeys([
        BigInt(roomId??""),
    ]) as Entity;

    const gameObject = useComponentValue(Game, entityId);

    const playerInGame = bigintToHex(gameObject?.room_owner_address??0n) == account.address || bigintToHex(gameObject?.invitee_address??0n) == account.address;
    const playerIsOwner = bigintToHex(gameObject?.room_owner_address??0n) == account.address;
    const playerIsInvitee = bigintToHex(gameObject?.invitee_address??0n) == account.address;
    const playerColor = playerInGame ? bigintToHex(gameObject?.white_player_address??0n) == account.address ? "white" : "black" : undefined;
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
    const inviteeTimeRemaining = (ownerIsWhite ? gameObject?.b_total_time_left : gameObject?.w_total_time_left)??0;
    const inviteeReady = gameObject?.invitee_ready;

    console.log("GameRoom: invitee address: ", gameObject?.invitee_address)
    console.log("GameRoom: invitee entity: ", inviteeEntity)

    const ownerNamePanel = useMemo(()=>{
        return (
            <div className="flex">
                        <span className="mx-4 text-xl">
                        {ownerName}
                        </span>

                        <Avatar className="h-8 w-8">
                            <AvatarImage src={ownerPfPurl} alt={"username"} />
                            <AvatarFallback>{ownerName}</AvatarFallback>
                        </Avatar>
            </div>
        )
    },[ownerName, ownerPfPurl])

    const inviteeNamePanel = useMemo(()=>{
        return (
            <div className="flex">
                        <span className="mx-4 text-xl">
                        {inviteeName}
                        </span>

                        <Avatar className="h-8 w-8">
                            <AvatarImage src={inviteePfPurl} alt={"username"} />
                            <AvatarFallback>{inviteeName}</AvatarFallback>
                        </Avatar>
            </div>
        )
    },[inviteeName, inviteePfPurl])

    const handleJoinGame = async() => {
        console.log("GameRoom: Joining Game...")
        if(roomId && roomId != "0"){
            await client.lobby.join_game({
                account: account,
                game_id: BigInt(roomId??0),
            })
        }
    }
    return (
        <div className="flex justify-center items-start flex-1
        ">
            <div className="grid-cols-2 grid gap-2
            w-4/5 h-[80vh]
            p-2
            border border-red-500
            ">

                {/* Chessboard column */}
                <div className="flex flex-col
                justify-center items-center h-[50vw] w-full
                border border-green-500">

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
                        ready={(playerInGame ?
                            (playerIsOwner ? inviteeReady : ownerReady)
                            : inviteeReady)??false}
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
                    

                    <div className="w-4/5 m-2 my-4">
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
                        ownerTimeRemaining=
                        {playerInGame ?  
                            (playerIsOwner ? String(ownerTimeRemaining) : String(inviteeTimeRemaining))
                            : String(ownerTimeRemaining)} 
                        ready={(playerInGame ?
                            (playerIsOwner ? ownerReady : inviteeReady)
                            : ownerReady)??false}
                    />

                </div>

                {/* Chat column */}
                <div className="flex flex-col
                justify-start items-center h-full w-full
                rounded-2xl overflow-hidden
                text-white bg-slate-900/70
                border-4 border-gray-700">
                    <div className="w-full p-3
                    ">Chat Title Bar</div>

                    <div className="w-full h-[80%]
                    ">Chat Box</div>

                    <div className="w-full h-[20%]
                    ">Chat Input</div>
                </div>

            </div>
        </div>
    )
}
