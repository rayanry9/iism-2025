import { DB_URL } from '$env/static/private';
import postgres from 'postgres';
import 'dotenv/config';

export const DB = postgres(DB_URL);

export interface RegisterData {
	name: string;
	phone: string;
	email: string;
	gender: string;
	age: string;
	dob: string;
	address: string;
	pincode: string;
	institute: string;
	class: string;
	blood: string;
	medical: string;
	hostel: string;
	sport: string;
	experience: string;
	gaurdianName: string;
	gaurdianPhone: string;
}

/* 

CREATE TABLE IF NOT EXISTS registrants(
	id SERIAL PRIMARY KEY,
	name TEXT,
	phone_number TEXT,
	email TEXT,
	gender TEXT,
	age TEXT,
	dob TEXT,
	address TEXT,
	pincode TEXT,
	institute TEXT,
	current_class TEXT,
	blood_group TEXT,
	medical_conditions TEXT,
	hostel_required TEXT,
	sport_choice TEXT,
	previous_experience TEXT,
	gaurdian_name TEXT,
	gaurdian_phone TEXT	
);

*/

export async function createRegistrant(data: RegisterData) {
	try {
		await DB`
		INSERT INTO 
			registrants 

			(name, phone_number, email, gender, age, dob, address, pincode, institute, current_class, blood_group, medical_conditions, hostel_required, sport_choice, previous_experience, gaurdian_name, gaurdian_phone)
		VALUES
			(${data.name}, ${data.phone}, ${data.email}, ${data.gender}, ${data.age}, ${data.dob}, ${data.address}, ${data.pincode}, ${data.institute}, ${data.class}, ${data.blood}, ${data.medical}, ${data.hostel}, ${data.sport}, ${data.experience}, ${data.gaurdianName}, ${data.gaurdianPhone})
	`;
		return true;
	} catch (err) {
		console.error(err);
		return false;
	}
}
