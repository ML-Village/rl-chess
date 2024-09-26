import React from 'react';

import {
    Tabs,
    TabsContent,
    TabsList,
    TabsTrigger,
} from "@/components/ui/tabs";

import { AccountsTable } from "@/components/Lobby/AccountsTable";
import { OpenRooms, InvitesTable, LiveGamesTable, YourGamesTable } from "@/components/Lobby";

import { useDojo } from "@/dojo/useDojo";
import { useComponentValue, useEntityQuery } from "@dojoengine/react";
import { Entity, Has, HasValue, getComponentValueStrict, getComponentValue } from "@dojoengine/recs";

export const LobbyTable = () => {

    const {
        setup: {
            clientComponents: { Game },
        },
        account: {account}
    } = useDojo();

    const hasInvites = useEntityQuery([HasValue(Game, 
        {
            invitee_address: BigInt(account.address),
            game_state: "Awaiting"
        })
    ]);

    const hasInviteeGames = useEntityQuery([
        HasValue(Game, 
        {
            invitee_address: BigInt(account.address)
        })
    ]);
    const hasInviterGames = useEntityQuery([
        HasValue(Game, 
        {
            room_owner_address: BigInt(account.address)
        })
    ]);
    const userGames = [...new Set([...hasInviteeGames, ...hasInviterGames])];
    
    const userLiveGames = userGames.map((entity)=>{
        return getComponentValue(Game, entity)
    })?.filter((game)=>{
        return (
            game?.game_state === "InProgress" || 
            game?.game_state === "Awaiting" ||
            game?.game_state === "Accepted"
        )
    })

    console.log("userLiveGames: ", userLiveGames);


    return (
        <Tabs defaultValue="openrooms" 
            className="w-full
            
            rounded-2xl rounded-t-lg overflow-hidden
            flex flex-col
            ">
            
            
            <TabsList className="w-full flex flex-wrap
                rounded-lg flex-1 mb-2 border-2 border-blue-800
                justify-start items-center
            ">
                <TabsTrigger className="grow" value="openrooms">Open Rooms</TabsTrigger>
                <TabsTrigger className="grow flex gap-x-1" value="invites">
                    <span >Invites</span>
                    {
                        hasInvites.length > 0 && (
                            <span className="flex h-[1.5rem] min-w-[1.5rem] items-center justify-center rounded-full 
                            bg-red-500 text-xs font-medium text-white
                            ">
                                {hasInvites.length}
                            </span>
                    )}
                </TabsTrigger>
                <TabsTrigger className="grow flex gap-x-1" value="yourgames">
                    <span>Your Games</span>
                    {
                        userLiveGames.length > 0 && (
                            <span className="flex h-[1.5rem] min-w-[1.5rem] items-center justify-center rounded-full 
                            bg-blue-900 text-xs font-medium text-white
                            ">
                                {userLiveGames.length}
                            </span>
                    )}
                </TabsTrigger>
                <TabsTrigger className="grow" value="livegames">Live Games</TabsTrigger>
                <TabsTrigger className="grow" value="accounts">Accounts</TabsTrigger>
            </TabsList>
            
            <div className="h-[70vh]
            rounded-2xl
            border-2 border-blue-950/80
            bg-blue-950
            ">
                <TabsContent value="openrooms"
                    className="h-full bg-blue-100/80"
                    >
                    <OpenRooms />
                </TabsContent>

                <TabsContent value="invites"
                    className="h-full bg-blue-100/80"
                    >
                    <InvitesTable />
                </TabsContent>

                <TabsContent value="yourgames"
                    className="h-full bg-blue-100/80"
                    >
                    <YourGamesTable />
                </TabsContent>

                <TabsContent value="livegames"
                    className="h-full bg-blue-100/80"
                    >
                    <LiveGamesTable />
                </TabsContent>

                <TabsContent value="accounts"
                    className="h-full bg-blue-100/80"
                    >
                    <AccountsTable />
                </TabsContent>
            </div>
        </Tabs>
    )
}
