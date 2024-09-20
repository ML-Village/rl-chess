import React, { useState, useEffect } from 'react';
import { FaClockRotateLeft } from "react-icons/fa6";
import { formatTimestampDaysHoursMinutesSeconds, 
    formatTimestampHoursMinutesSeconds,
    formatTimestampMinutesSeconds } from '@/utils';

// Dojo stuff
import { useDojo } from "@/dojo/useDojo";
import { useComponentValue, useEntityQuery } from "@dojoengine/react";
import { Entity, Has, HasValue, getComponentValueStrict, getComponentValue } from "@dojoengine/recs";
import { getEntityIdFromKeys } from "@dojoengine/utils";

export const PlayerPanel = ({ownerNamePanel, ownerLastMoveTime, ownerTimeRemaining, ready, player_turn, game_state}
    :{ownerNamePanel: JSX.Element, 
        ownerLastMoveTime: string, 
        ownerTimeRemaining: string, 
        ready: boolean, 
        player_turn: boolean,
        game_state: string
    }
) => {
    const lastMoveTime = Number(ownerLastMoveTime);
    console.log("lastMoveTime", new Date(lastMoveTime * 1000).getTime());
    console.log("Date.now()", Date.now());
    const timeDeltaSinceLastMove = lastMoveTime== 0 ? 0 : Date.now() - new Date(lastMoveTime * 1000).getTime();
    console.log("timeDeltaSinceLastMove", timeDeltaSinceLastMove);
    const ownerRealRemainingTime = Number(ownerTimeRemaining) - timeDeltaSinceLastMove;
    console.log("ownerRealRemainingTime", ownerRealRemainingTime);

    const [timeRemaining, setTimeRemaining] = useState(
        Number(ownerRealRemainingTime) >= 86400 ?
        formatTimestampDaysHoursMinutesSeconds(Number(ownerRealRemainingTime)) :
        Number(ownerRealRemainingTime) >= 3600 ?
        formatTimestampHoursMinutesSeconds(Number(ownerRealRemainingTime)) :
        formatTimestampMinutesSeconds(Number(ownerRealRemainingTime))
    );

    // useEffect to update timeRemaining every second
    // but only start if game_state is "InProgress"
    useEffect(() => {
        if (game_state === "InProgress") {
            const interval = setInterval(() => {
                setTimeRemaining(formatTimestampDaysHoursMinutesSeconds(Number(ownerRealRemainingTime)));
            }, 1000);
            return () => clearInterval(interval);
        }
    }, [game_state, ownerRealRemainingTime]);

    return (
        <div className="w-full m-4 px-10 flex items-center
        ">
            <div className="w-full p-3 px-1 flex flex-col justify-center
            rounded-2xl border-2 border-blue-900/80
                ">
                    <div className="flex items-center w-full">
                        {ownerNamePanel}
                    </div>

                    <div className="w-full flex items-center">
                        <div className="ml-auto mr-2">{
                            timeRemaining
                        }</div>
                        <FaClockRotateLeft className="mx-2" />
                        <div className={`
                            mx-2 mr-4
                            ${ready ? "bg-green-600" : "bg-red-600"} rounded-full w-4 aspect-square
                            `} />
                    </div>
            </div>
        </div>
    )
}