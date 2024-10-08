import React from 'react'

export const TitleBar = ({ownerName, inviteeName}:{ownerName: string, inviteeName: string}) => {
    return (
        <div className="w-full p-3 py-1 my-2 mt-4
        flex items-center justify-center
        gap-x-3 text-3xl font-semibold
        ">
            <span className="">{ownerName == ""? "??": ownerName}</span>
            <span>vs</span>
            <span className="">{inviteeName == ""? "??": inviteeName}</span>
        </div>
    )
}
