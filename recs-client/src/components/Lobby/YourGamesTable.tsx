import React from 'react';
import { useNavigate } from 'react-router-dom';
import {
    Table,
    TableBody,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
} from "@/components/ui/table";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import { useDojo } from "@/dojo/useDojo";
import { useComponentValue, useEntityQuery } from "@dojoengine/react";
import { Entity, Has, HasValue, getComponentValueStrict, getComponentValue } from "@dojoengine/recs";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { pfpCardImageUrl } from '@/constants/assetspath';
import { bigintToHex, formatTimestamp, formatAddress} from "@/utils";
import { feltToString, stringToFelt } from "@/utils/starknet";
import { gameFormatconfig } from "@/constants/gameformat";
import { FaChessBoard, FaRegChessKnight } from "react-icons/fa6";
import { FaChessKnight } from "react-icons/fa";
import { IoMdInfinite } from "react-icons/io";
import { format as formatDateFNS } from "date-fns";

export const YourGamesTable = () => {

    const {
        setup: {
            clientComponents: { Game, Player },
        },
        account: {account}
    } = useDojo();
    const navigate = useNavigate();

    const hasGames = useEntityQuery([Has(Game)]);

    const gamesData = hasGames.map((entity) => {
        const g = getComponentValue(Game, entity)
        const generatedEntity = getEntityIdFromKeys([
            BigInt(g?.game_id??0n)?? BigInt("0x0"),
        ]) as Entity;
        return {
            generated_game_entity: generatedEntity,
            game_entity: entity,
            ...g
        }
    })

    // Filtering for games that you got invited
    const newGamesData = gamesData?.filter((game) => {
        return (
            (bigintToHex(game?.invitee_address??0n) == account.address || bigintToHex(game?.room_owner_address??0n) == account.address)
                &&
            (game?.game_state == "Accepted" || game?.game_state == "InProgress" || game?.game_state == "Awaiting")
        )
    }).map((game) => {

        //const ownerAddress = bigintToHex(game?.room_owner_address)
        const ownerEntity = getEntityIdFromKeys([
                                game?.room_owner_address??0n,
                            ]) as Entity;
        const player = getComponentValue(Player, ownerEntity)??{}
        const playerName = player?.name ? feltToString(String(player?.name ?? "")) : "???";

        const inviteeEntity = getEntityIdFromKeys([
            game?.invitee_address??0n,
        ]) as Entity;
        const invitee = getComponentValue(Player, inviteeEntity)??{}
        const inviteeName = invitee?.name ? feltToString(String(invitee?.name ?? "")) : "???";
    
        return {
            ...game,
            game_format_id: game?.game_format_id,
            game_id: BigInt(game?.game_id??0n).toString(),
            owner_name: playerName??"??",
            invitee_name: inviteeName??"??",
            room_owner_address: player?.address??0n,
            invitee_address: invitee?.address??0n,
            owner_entity: ownerEntity,
            profile_pic_type: player?.profile_pic_type ?? "",
            profile_pic_uri: player?.profile_pic_uri ?? "0",
            invitee_pic_type: invitee?.profile_pic_type ?? "",
            invitee_pic_uri: invitee?.profile_pic_uri ?? "0",
            owner_color: (game?.white_player_address == game?.room_owner_address) ? "w" : "b",
            room_start: formatTimestamp(game?.room_start??0),
        }
    })
    //console.log("openrooms.tsx: newGamesData: ", newGamesData)
    return (
        <Table>
            <TableHeader >
                <TableRow className="bg-blue-950
                hover:bg-blue-950
                ">
                    
                    <TableHead className="text-white px-8">Creator</TableHead>
                    <TableHead className="text-center text-white">Invitee</TableHead>
                    <TableHead className="text-center text-white">Game Type</TableHead>
                    <TableHead className="text-center text-white">Status</TableHead>
                </TableRow>
            </TableHeader>
            <TableBody>
                {newGamesData.map((g, i) => {

                    let profilePicNum = g?.profile_pic_uri??0
                    profilePicNum = (typeof(profilePicNum) === "number") ? profilePicNum : 0;

                    let inviteeProfilePicNum = g?.invitee_pic_uri??0
                    inviteeProfilePicNum = (typeof(inviteeProfilePicNum) === "number") ? inviteeProfilePicNum : 0;

                    
                    const GameFormatIcon = gameFormatconfig[g?.game_format_id??1]?.icon ?? FaChessBoard;
                    
                    //console.log("got entity?", g?.game_entity)

                    return (
                    <TableRow key={"accounts_"+i}
                        className={`hover:cursor-pointer
                        ${i % 2 === 0 ? 
                            'bg-white/20 text-black hover:bg-white' 
                            : 
                            'bg-blue-900/80 text-white hover:text-black'}
                        `}
                        onClick={()=>navigate(`/room/${g?.game_id}`)}
                    >
                        

                        <TableCell className="">
                            <div className="flex flex-nowrap 
                            justify-start items-center
                            ">
                                <Avatar className="mx-2">
                                    <AvatarImage src={pfpCardImageUrl[profilePicNum]} alt={g?.owner_name ?? "??"} />
                                    <AvatarFallback>P</AvatarFallback>
                                </Avatar>
                                <span className="mx-2">{g?.owner_name ?? "??"}</span>
                                <FaChessKnight className={`h-6 w-6 p-1 rounded-full
                                    ${g?.owner_color == "w" ? "text-white bg-lime-600" : "text-black bg-orange-100"}
                                `}/>
                            </div>
                        </TableCell>

                        <TableCell className="">
                            <div className="flex flex-nowrap 
                            justify-start items-center
                            ">
                                <Avatar className="mx-2">
                                    <AvatarImage src={pfpCardImageUrl[inviteeProfilePicNum]} alt={g?.invitee_name ?? "??"} />
                                    <AvatarFallback>P</AvatarFallback>
                                </Avatar>
                                <span className="mx-2">{g?.invitee_name ?? "??"}</span>
                                <FaChessKnight className={`h-6 w-6 p-1 rounded-full
                                    ${g?.owner_color == "b" ? "text-white bg-lime-600" : "text-black bg-orange-100"}
                                `}/>
                            </div>
                        </TableCell>
                    
                        <TableCell className="">
                            <div className="flex flex-nowrap 
                            justify-center space-x-1
                            items-center
                            ">
                                <GameFormatIcon className="font-bold text-lg
                                
                                "/>
                                <span>
                                    {gameFormatconfig[g?.game_format_id??1]?.description ?? "na"}
                                </span>
                            </div>
                        </TableCell>

                        <TableCell className="text-center">{
                            g?.game_state == "InProgress" ? 
                            <button className="bg-lime-600 text-white rounded-md px-2 py-1">
                                In Progress
                            </button>
                            :
                            `${formatDateFNS(g?.invite_expiry * 1000, "MMM, d HH:mm")} hrs`
                            ??<IoMdInfinite/>
                        }</TableCell>
                        
                    </TableRow>
                    );
                })}
            </TableBody>
        </Table>
    )
}
