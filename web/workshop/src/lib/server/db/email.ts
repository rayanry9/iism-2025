import { SMTP_EMAIL, SMTP_PASSWORD } from '$env/static/private';
import nodemailer from 'nodemailer';

const transporter = nodemailer.createTransport({
	service: 'Gmail',
	auth: {
		user: SMTP_EMAIL,
		pass: SMTP_PASSWORD
	}
});

export async function SendMail(to: string) {
	const info = await transporter.sendMail({
		from: '"INTER IIT OC" <rayanhldr@gmail.com>',
		to: to,
		subject: 'Thank you for Registering for the IITH Sports Camp',
		text: 'Hi, you have registered for the sports workshop'
	});
	if (info.accepted) {
		return true;
	} else {
		return false;
	}
}

process.on('SIGTERM', () => {
	transporter.close();
	process.exit(0);
});
