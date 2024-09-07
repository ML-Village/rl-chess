import React from 'react';
import { useComponentValue, useEntityQuery } from "@dojoengine/react";
import { useDojo } from "@/dojo/useDojo";
import { Entity, Has, HasValue, getComponentValueStrict } from "@dojoengine/recs";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import * as torii from "@dojoengine/torii-client";
import * as models from "@/dojo/typescript/models.gen";
import { ProfilePicType } from "@/types";


export const Debug = () => {
    const {
        setup: {
            clientComponents: { Player },
            client,
        },
        account: { account },

    } = useDojo();

    console.log("account:", account);
    console.log("account address:", account?.address);

    // entity id we are syncing
    const entityId = getEntityIdFromKeys([BigInt(account.address)]) as Entity;
    console.log("entityId:", entityId);

    const player = useComponentValue(Player, entityId);
    console.log("player:", player);

    const hasPlayers = useEntityQuery([Has(Player)]);
    console.log("hasPlayers:", hasPlayers);

    return (
        <div className="flex flex-col items-center justify-center h-screen">
            <h1 className="text-4xl font-bold">Debug</h1>

            <button 
                className="bg-blue-500 hover:bg-blue-700 text-white 
                    font-bold py-2 px-4 m-2
                    rounded-lg border
                    "
                onClick={async () => {
                await client.lobby.register_player(
                    { 
                        account, 
                        name: BigInt(torii.cairoShortStringToFelt("Tester1")), 
                        profile_pic_type: {type: ProfilePicType[1]} as models.ProfilePicType, 
                        profile_pic_uri: BigInt(torii.cairoShortStringToFelt("Tester1")),
                    });
            }}>Register Player</button>

            
        </div>
    )
}
