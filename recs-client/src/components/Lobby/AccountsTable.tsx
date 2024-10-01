import React from 'react';
import {
    Table,
    TableBody,
    TableCaption,
    TableCell,
    TableFooter,
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
import { formatAddress, bigintToHex } from "@/utils";
import { feltToString, stringToFelt } from "@/utils/starknet";
import { FaCopy } from "react-icons/fa";

export const AccountsTable = () => {
    const {
        setup: {
            clientComponents: { Player },
            client
        },
        //account,
    } = useDojo();

    const hasPlayers = useEntityQuery([Has(Player)]);

    // sort by highest ELO
    const playerData = hasPlayers.map((entity) => {
        return getComponentValue(Player, entity)
    }).sort((a, b) => (b?.elo??0) - (a?.elo??0));

    //console.log("playerData", playerData)

    return (
        <Table>
            <TableHeader>
                <TableRow className="bg-blue-950
                hover:bg-blue-950
                ">
                    <TableHead className="w-[80px] text-center text-white">Profile</TableHead>
                    <TableHead className="w-[200px] text-white">Name</TableHead>
                    <TableHead className="text-white">Address</TableHead>
                    <TableHead className="text-center text-white">ELO</TableHead>
                    <TableHead className="text-center text-white">Wins</TableHead>
                    <TableHead className="text-center text-white">Draws</TableHead>
                    <TableHead className="text-center text-white">Losses</TableHead>
                </TableRow>
            </TableHeader>
            <TableBody>
                {playerData.map((p, i) => {
                    let profilePicNum = p?.profile_pic_uri??0
                        profilePicNum = (typeof(profilePicNum) === "number") ? profilePicNum : 0;
                    return (
                    <TableRow key={"accounts_"+i}
                        className={`
                        ${i % 2 === 0 ? 
                        'bg-white/20 text-black hover:bg-white' 
                        : 
                        'bg-blue-900/80 text-white hover:text-black'}
                    `}
                    >
                        <TableCell className="text-center">
                            <Avatar>
                                <AvatarImage src={pfpCardImageUrl[profilePicNum]} alt={p?.name ? feltToString(String(p?.name)) :""} />
                                <AvatarFallback>P</AvatarFallback>
                            </Avatar>

                        </TableCell>
                        <TableCell className="">{p?.name ? feltToString(String(p?.name)) :""}</TableCell>
                        <TableCell className="">{p?.address ? 
                        <div className="flex items-center gap-x-1">
                            <span>{formatAddress(bigintToHex(p?.address))}</span>
                            <FaCopy className="cursor-pointer"
                            onClick={() => navigator.clipboard.writeText(bigintToHex(p?.address))} />
                        </div> :""}</TableCell>
                        <TableCell className="text-center">{p?.elo ? p?.elo : "??"}</TableCell>
                        <TableCell className="text-center">0</TableCell>
                        <TableCell className="text-center">0</TableCell>
                        <TableCell className="text-center">0</TableCell>
                    </TableRow>
                    );
                })}
            </TableBody>
        </Table>
    )
}
