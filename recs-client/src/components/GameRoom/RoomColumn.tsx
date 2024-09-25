import React, { useMemo} from 'react';

import { useComponentValue, useEntityQuery } from "@dojoengine/react";
import { Entity, Has, HasValue, getComponentValueStrict, getComponentValue } from "@dojoengine/recs";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import { useDojo } from "@/dojo/useDojo";

import { TitleBar, GameRoomControls } from '@/components/GameRoom';
import { Button } from '@/components/ui/button';
import {
    Table,
    TableHeader,
    TableBody,
    TableCell,
    TableRow,
} from "@/components/ui/table"

export const RoomColumn = ({roomId, ownerName, inviteeName}:{roomId:string, ownerName: string, inviteeName: string}) => {
    
    const {
        setup: {
            clientComponents: { Game, Board, Player, History },
            client
        },
        account:{account},
    } = useDojo();

    const entityId = getEntityIdFromKeys([
        BigInt(roomId??""),
    ]) as Entity;
    const historyObject = useComponentValue(History, entityId);

    const move_history_table = useMemo(() => {
        if (!historyObject) return [];
        return historyObject?.move_history_string.split('/').map((mh) => {
            return mh.split(' ')
                    .filter(s => s !== '');
        }).filter(ms => ms.length > 0).map((ms) => {
            //const move = ms.split(' ');
            //console.log("move length", move.length)
            //console.log("ms", ms)
            if(ms.length == 3){
                return [ms[1], ms[2]];
            }
            else if(ms.length == 2){
                return [ms[1], ""];
            }
        });
    }, [historyObject, entityId]);

    return (
        <div className="flex flex-col
                justify-start items-center h-full w-[28vw]
                rounded-2xl overflow-hidden
                text-white bg-gray-800/80
                border-2 border-orange-500">
            
            <TitleBar ownerName={ownerName} inviteeName={inviteeName} />

            <GameRoomControls roomId={roomId}/>

            <div className="w-full
            my-2
            ">
                <div className="
                mx-6 h-[35vh] px-1
                bg-black/30
                border border-blue-950/80 rounded-lg overflow-y-hidden">
                    <div className="text-xs text-white py-1.5 p-2 text-transparent">
                            placeholder
                    </div>
                    <div className="h-full overflow-y-scroll pb-2 pt-1">
                        <Table className="h-full">
                            <TableBody className="text-xs h-full
                            overflow-y-scroll
                            ">
                                {
                                    move_history_table.map((move, i) => (
                                        <TableRow className="hover:bg-inherit border-none w-full">
                                            <TableCell className="p-1 px-2 mx-1 h-6 w-[1em] text-center">{i + 1}.</TableCell>
                                            <TableCell className="p-1 h-6 mx-2 text-center">
                                                <span className="hover:bg-white/40 hover:cursor-pointer rounded-sm p-1">{move[0]}</span>
                                            </TableCell>
                                            <TableCell className="p-1 h-6 mx-2 text-center">
                                                <span className="hover:bg-white/40 hover:cursor-pointer rounded-sm p-1">{move[1]}</span>
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

                {/* Chat Window */}
            <div className="w-full
            flex-1 pb-2
            ">
                <div className="
                flex flex-col justify-start
                mx-6 pb-2 h-full">
                    
                    {/* text window */}
                    <div className="flex flex-col
                    h-full w-full mb-2
                    border border-blue-950/80 rounded-lg
                    bg-black/30
                    ">

                    </div>


                    {/* input window */}
                    <div className="flex 
                    items-center
                    ">
                        <input 
                        className="
                        w-full
                        text-base p-3
                        bg-black/30 overflow-hidden
                        rounded-xl 
                        border border-blue-950/80
                        "
                        type="text" placeholder="Type your message here" />
                        
                        <Button
                        className="mx-1 ml-2
                        px-3
                        rounded-lg
                        bg-orange-500
                        text-blue-950 hover:text-white 
                        font-semibold
                        "
                        >
                            Send
                            </Button>
                    </div>
                </div>
            </div>


        </div>
    )
}
