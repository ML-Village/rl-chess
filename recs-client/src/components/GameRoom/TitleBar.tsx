import React from 'react'

export const TitleBar = ({ownerName, inviteeName}:{ownerName: string, inviteeName: string}) => {
    return (
        <div className="w-full p-3 my-2
        flex items-center justify-center
        gap-x-3
                    ">
            <span className="text-xl">{ownerName}</span>
            <span>vs</span>
            <span className="text-xl">{inviteeName}</span>
        </div>
    )
}
