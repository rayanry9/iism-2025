from PIL import Image, ImageDraw, ImageFont

for i in range(10):
    with Image.open("./background.png") as schedule_front_img:
        draw = ImageDraw.Draw(schedule_front_img)
        font = ImageFont.truetype("../../fonts/Neue_Haas_Grotesk_Collection/Neue Haas Grotesk Display Family/NeueHaasGrotDisp-55Roman-Trial.otf", size=210)

        draw.text((124, 658), f'Day {i}', fill=(254,254,254), font=font)
        schedule_front_img.save(f'outputs/day_{i}.png')

