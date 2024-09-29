import React, { useMemo, useEffect,useRef } from 'react';

import { useComponentValue, useEntityQuery } from "@dojoengine/react";
import { Entity, Has, HasValue, getComponentValueStrict, getComponentValue } from "@dojoengine/recs";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import { useDojo } from "@/dojo/useDojo";

import {
    Table,
    TableHeader,
    TableBody,
    TableCell,
    TableRow,
} from "@/components/ui/table";

import { parseMoveHistory } from "@/utils";

export const MoveHistoryTable = ({roomId}:{roomId:string}) => {
    const {
        setup: {
            clientComponents: { History },
        },
    } = useDojo();

    const tableRef = useRef<HTMLDivElement>(null);

    const entityId = getEntityIdFromKeys([
        BigInt(roomId??""),
    ]) as Entity;
    const historyObject = useComponentValue(History, entityId);
    console.log("MoveHistoryTable: historyObject: ", historyObject)

    const move_history_table = useMemo(() => {
        if (!historyObject) return [];

        //console.log("MoveHistoryTable: historyObject: ", historyObject)
        return historyObject?.move_history_string.split('/').map((mh) => {
            return mh.split(' ')
                    .filter(s => s !== '');
        }).filter(ms => ms.length > 0).map((ms) => {
            if(ms.length == 3){
                return [ms[1], ms[2]];
            }
            else if(ms.length == 2){
                return [ms[1], ""];
            }
        });
    }, [historyObject, entityId]);

    useEffect(() => {
        if (tableRef.current) {
            tableRef.current.scrollTop = tableRef.current.scrollHeight;
        }
    }, [move_history_table]);

    return (
        <div className="w-full
            my-2
            ">
                <div className="
                mx-6 h-[35vh] px-1
                bg-black/30
                border border-blue-950/80 rounded-lg overflow-y-hidden">
                    <div className="text-xs pt-2.5 pb-1 px-3 text-transparent">
                            placeholder
                    </div>
                    <div ref={tableRef} className="h-full overflow-y-auto pb-2 pt-1">
                        <Table className="h-full">
                            <TableBody className="text-sm h-full
                            overflow-y-scroll
                            ">
                                {
                                    move_history_table.map((move, i) => (
                                        <TableRow key={i+"_move_hist"}
                                            className={`border-none w-full ${i % 2 === 0 ? 'bg-transparent hover:bg-inherit' : 'bg-white/10 hover:bg-white/20'}`}>
                                            <TableCell className="p-1 px-2 mx-1 h-6 w-[1em] text-center">{i + 1}.</TableCell>
                                            <TableCell className="p-1 h-8 mx-2 text-center">
                                                <span className="hover:bg-white/40 hover:cursor-pointer rounded-sm p-1 
                                                flex items-center justify-end w-[3.5em]">{
                                                    parseMoveHistory(move[0])}
                                                </span>
                                            </TableCell>
                                            <TableCell className="p-1 h-8 mx-2 text-center">
                                                <span className="hover:bg-white/40 hover:cursor-pointer rounded-sm p-1 
                                                flex items-center justify-end w-[3.5em]">{
                                                    parseMoveHistory(move[1])}
                                                </span>
                                            </TableCell>
                                            <TableCell className="p-1 h-6 text-center w-1/3"> </TableCell>
                                        </TableRow>
                                    ))
                                }
                            </TableBody>
                        </Table>
                    </div>
                </div>
            </div>
    )
}
