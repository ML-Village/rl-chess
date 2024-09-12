import React from 'react';
import { FaClockRotateLeft } from "react-icons/fa6";
import { formatTimestampDaysHoursMinutesSeconds, 
    formatTimestampHoursMinutesSeconds,
    formatTimestampMinutesSeconds } from '@/utils';

export const PlayerPanel = ({ownerNamePanel, ownerTimeRemaining, ready}
    :{ownerNamePanel: JSX.Element, ownerTimeRemaining: string, ready: boolean}
) => {
    
    return (
        <div className="w-full m-4 px-10 flex items-center
        ">
            <div className="w-full p-3 flex items-center
            rounded-2xl border-2 border-blue-900/80
                ">
                    <div className="flex items-center">{ownerNamePanel}</div>

                    <div className="ml-auto mr-2">{
                        Number(ownerTimeRemaining) >= 86400 ?
                        formatTimestampDaysHoursMinutesSeconds(Number(ownerTimeRemaining)) :
                        Number(ownerTimeRemaining) >= 3600 ?
                        formatTimestampHoursMinutesSeconds(Number(ownerTimeRemaining)) :
                        formatTimestampMinutesSeconds(Number(ownerTimeRemaining))
                    }</div>
                    <FaClockRotateLeft className="mx-2" />
                    <div className={`
                        mx-2 mr-4
                        ${ready ? "bg-green-600" : "bg-red-600"} rounded-full w-4 aspect-square
                        `} />
            </div>
        </div>
    )
}