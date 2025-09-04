from PIL import Image, ImageDraw, ImageFont

with Image.open("ID STAFF FRONT.png") as id_card_img:
    
    draw = ImageDraw.Draw(id_card_img)
    font = ImageFont.truetype("NeueHaasGrotText-55Roman-Trial.otf", size=24)
    font_bold = ImageFont.truetype("NeueHaasGrotText-75Bold-Trial.otf", size=24)

    draw.text((65, 400), "Rayan HalderRayan Rayan Rayan Rayan Rayan Rayan Rayan ", fill=(0,0,0), font=font_bold)
    draw.text((65, 450), "IIT Hyderabad", fill=(0,0,0), font=font_bold)

    id_card_img.show()


