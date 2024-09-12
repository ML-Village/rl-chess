import React from 'react';
import { LobbyControls, LobbyTable, LobbyEvents, LobbyControlsController } from "@/components";

export const LobbyPage = () => {
    return (
        <div>

            {/* CreateGame Play a Friend Button */}
            {/* <LobbyControls/> */}
            {import.meta.env.VITE_USECONTROLLER == "true" ?
            <LobbyControlsController/>
            :
            <LobbyControls/>
            }

            <div className="
            w-full flex justify-center
            
            ">
                <div className="w-2/3
                flex justify-center space-x-4

                ">
                    <LobbyTable />

                    {/* Right Side of Lobby that features a top game */}
                    <LobbyEvents />
                </div>
            </div>
        </div>
    )
}
