import { SMTP_EMAIL, SMTP_PASSWORD } from '$env/static/private';
import nodemailer from 'nodemailer';
import type { RegisterData } from './register';
import term from '../../../../static/Terms_and_Conditions.pdf';
import { read } from '$app/server';

const file = read(term);
const fileData = await file.arrayBuffer();

const transporter = nodemailer.createTransport({
	service: 'Gmail',
	auth: {
		user: SMTP_EMAIL,
		pass: SMTP_PASSWORD
	}
});

export async function SendMail(data: RegisterData) {
	const info = await transporter.sendMail({
		from: '"IIT Hyderabad Sports" <interiit.oc@iith.ac.in>',
		to: data.email,
		subject: 'Confirmation of Registration – Sports Summer Camp at IIT Hyderabad',
		html: `Dear ${data.name},<br/><br/>
Greetings from IIT Hyderabad!<br/>
Thank you for registering for the Sports Summer Camp organized at IIT Hyderabad. This is an automated confirmation email to acknowledge the successful receipt of your registration.<br/>
We are excited to have you with us and look forward to a fun, active, and enriching summer experience.<br/>
Please note:<br/>
The General Instructions and Terms & Conditions for the camp are attached below. We request you to go through them carefully to ensure a smooth and enjoyable experience.<br/>
Further details regarding the schedule, venue, and specific requirements will be shared with you soon via email or WhatsApp.<br/>
If you have any questions, feel free to reach out to us at interiit.oc@iith.ac.in or contact our Events head at +91 7499816792 or +91 7396641098.<br/><br/>
Warm regards,<br/>
Team Sports Summer Camp<br/>
IIT Hyderabad`,
		attachments: [
			{
				filename: 'Terms & Conditions and General Instructions.pdf',
				content: Buffer.from(fileData),
				contentType: 'application/pdf'
			}
		]
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
