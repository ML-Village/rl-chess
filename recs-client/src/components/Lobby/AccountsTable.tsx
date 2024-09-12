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
import { feltToString, stringToFelt } from "@/utils/starknet";

export const AccountsTable = () => {
    const {
        setup: {
            clientComponents: { Player },
            client
        },
        //account,
    } = useDojo();

    const hasPlayers = useEntityQuery([Has(Player)]);

    const playerData = hasPlayers.map((entity) => {
        return getComponentValue(Player, entity)
    })

    return (
        <Table>
            <TableHeader>
                <TableRow className="bg-blue-950
                hover:bg-blue-950
                ">
                    <TableHead className="w-[80px] text-center text-white">Profile</TableHead>
                    <TableHead className="w-[200px] text-white">UserName</TableHead>
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
                    <TableRow key={"accounts_"+i}>
                        <TableCell className="text-center">
                            <Avatar>
                                <AvatarImage src={pfpCardImageUrl[profilePicNum]} alt={p?.name ? feltToString(String(p?.name)) :""} />
                                <AvatarFallback>P</AvatarFallback>
                            </Avatar>

                        </TableCell>
                        <TableCell className="">{p?.name ? feltToString(String(p?.name)) :""}</TableCell>
                        <TableCell className="text-center">0</TableCell>
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
