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
}
export interface GetPlayerCount {
	count: number;
}
