import type { IITNames } from './iitNames';

export interface UserDetails {
	firstName: string;
	middleName: string | null;
	lastName: string | null;
	gender: string;
	email: string;
	profilePic: string | null;
	contactNo: string | null;
	emergencyContactNo: string | null;
	bloodGroup: string | null;
	foodPreference: string | null;
	hostel: string | null;
	checkInDate: string | null;
	checkOutDate: string | null;
	assignedId: string | null;
	role: number;
	staff: boolean;
	extra: string | null;
	institute: IITNames;
	sportId: number | null;
}

export interface GetPlayers {
	userId: string;
	profilePic: string;
	firstName: string;
	middleName: string | null;
	lastName: string | null;
	extra: string | null;
	isPrimary: boolean;
}
export interface GetPlayerCount {
	sportId: number;
	count: number;
	secondaryCount: number;
	reserveCount: number;
}

export interface GetPlayerData {
	firstName: string;
	middleName: string | null;
	lastName: string | null;
	gender: string;
	email: string;
	profilePic: string;
	contactNo: string;
	emergencyContactNo: string;
	bloodGroup: string;
	jersey: string | null;
	foodPreference: string;
	checkInDate: string;
	checkOutDate: string;
	designation: string | null;
	remark: string | null;
	sports: {
		sportId: number;
		reserve: boolean;
		extra: string | null;
		secondary: boolean;
	}[];
}
