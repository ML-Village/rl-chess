import {create} from 'zustand';

interface toggleSoundStoreState {
    mute: boolean;
    setMute: (value:boolean) => void;
}
export const useToggleSoundStore = create<toggleSoundStoreState>((set) => ({
    mute: false,
    setMute: (value: boolean) => set({ mute: value }),
}));