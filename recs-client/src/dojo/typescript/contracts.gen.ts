
// Generated by dojo-bindgen on Tue, 1 Oct 2024 10:56:20 +0000. Do not modify this file manually.
// Import the necessary types from the recs SDK
// generate again with `sozo build --typescript` 
import { Account, byteArray } from "starknet";
import { DojoProvider } from "@dojoengine/core";
import * as models from "./models.gen";

export type IWorld = Awaited<ReturnType<typeof setupWorld>>;

export async function setupWorld(provider: DojoProvider) {
    // System definitions for `rl_chess-admin` contract
    function admin() {
        const contract_name = "admin";

        
        // Call the `world` system with the specified Account and calldata
        const world = async (props: { account: Account }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "world",
                        calldata: [],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `add_game_format` system with the specified Account and calldata
        const add_game_format = async (props: { account: Account, description: bigint, turn_expiry: number, total_time_per_side: number, total_time_string: bigint, increment: number, available: boolean }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "add_game_format",
                        calldata: [props.description,
                props.turn_expiry,
                props.total_time_per_side,
                props.total_time_string,
                props.increment,
                props.available],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `remove_game_format` system with the specified Account and calldata
        const remove_game_format = async (props: { account: Account, format_id: number }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "remove_game_format",
                        calldata: [props.format_id],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

        return {
            world, add_game_format, remove_game_format
        };
    }

    // System definitions for `rl_chess-lobby` contract
    function lobby() {
        const contract_name = "lobby";

        
        // Call the `world` system with the specified Account and calldata
        const world = async (props: { account: Account }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "world",
                        calldata: [],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `register_player` system with the specified Account and calldata
        const register_player = async (props: { account: Account, name: bigint, profile_pic_type: models.ProfilePicType, profile_pic_uri: number }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "register_player",
                        calldata: [props.name,
                ["Undefined", "Native", "External"].indexOf(props.profile_pic_type.type),
                props.profile_pic_uri],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `update_player` system with the specified Account and calldata
        const update_player = async (props: { account: Account, profile_pic_type: models.ProfilePicType, profile_pic_uri: number }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "update_player",
                        calldata: [["Undefined", "Native", "External"].indexOf(props.profile_pic_type.type),
                props.profile_pic_uri],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `create_invite_game` system with the specified Account and calldata
        const create_invite_game = async (props: { account: Account, game_format_id: number, invitee_address: bigint, invite_expiry: number }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "create_invite_game",
                        calldata: [props.game_format_id,
                props.invitee_address,
                props.invite_expiry],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `update_invitee` system with the specified Account and calldata
        const update_invitee = async (props: { account: Account, game_id: bigint, invitee_address: bigint, invite_expiry: number }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "update_invitee",
                        calldata: [props.game_id,
                props.invitee_address,
                props.invite_expiry],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `reply_invite` system with the specified Account and calldata
        const reply_invite = async (props: { account: Account, game_id: bigint, accepted: boolean }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "reply_invite",
                        calldata: [props.game_id,
                props.accepted],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `create_game` system with the specified Account and calldata
        const create_game = async (props: { account: Account, game_format_id: number, invite_expiry: number }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "create_game",
                        calldata: [props.game_format_id,
                props.invite_expiry],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `join_game` system with the specified Account and calldata
        const join_game = async (props: { account: Account, game_id: bigint }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "join_game",
                        calldata: [props.game_id],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `leave_game` system with the specified Account and calldata
        const leave_game = async (props: { account: Account, game_id: bigint }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "leave_game",
                        calldata: [props.game_id],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `ready_up` system with the specified Account and calldata
        const ready_up = async (props: { account: Account, game_id: bigint }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "ready_up",
                        calldata: [props.game_id],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `owner_withdraw_game` system with the specified Account and calldata
        const owner_withdraw_game = async (props: { account: Account, game_id: bigint }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "owner_withdraw_game",
                        calldata: [props.game_id],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `switch_sides` system with the specified Account and calldata
        const switch_sides = async (props: { account: Account, game_id: bigint }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "switch_sides",
                        calldata: [props.game_id],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `start_game` system with the specified Account and calldata
        const start_game = async (props: { account: Account, game_id: bigint }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "start_game",
                        calldata: [props.game_id],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

        return {
            world, register_player, update_player, create_invite_game, update_invitee, reply_invite, create_game, join_game, leave_game, ready_up, owner_withdraw_game, switch_sides, start_game
        };
    }

    // System definitions for `rl_chess-room` contract
    function room() {
        const contract_name = "room";

        
        // Call the `world` system with the specified Account and calldata
        const world = async (props: { account: Account }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "world",
                        calldata: [],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `move` system with the specified Account and calldata
        const move = async (props: { account: Account, game_id: bigint, move_from: number, move_to: number, promotion: number }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "move",
                        calldata: [props.game_id,
                props.move_from,
                props.move_to,
                props.promotion],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `get_fen` system with the specified Account and calldata
        const get_fen = async (props: { account: Account, game_id: bigint }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "get_fen",
                        calldata: [props.game_id],
                    },
                    "rl_chess"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

        return {
            world, move, get_fen
        };
    }

    return {
        admin: admin(),
        lobby: lobby(),
        room: room()
    };
}
