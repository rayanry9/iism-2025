from PIL import Image, ImageDraw, ImageFont

with open("cert_data.txt", "r") as data:
    lines = data.readlines()

    for idx in range(0,len(lines),2):
        position = lines[idx].strip()
        name = lines[idx+1].strip() 
        with Image.open("intern_cert.png") as cert:
            draw = ImageDraw.Draw(cert)
            font = ImageFont.truetype("../web/main/static/optima-nova-lt-pro/OptimaNovaLTProRegular.otf", size=74)
            font_bold = ImageFont.truetype("../web/main/static/optima-nova-lt-pro/OptimaNovaLTProDemi.otf", size=200)

            draw.text((985, 1270), name, fill=(0,0,0), font=font_bold)
            draw.text((2565, 1556), position, fill=(0,0,0), font=font)

            cert.save(f"cert_out/{name}.png")
            print(f"{(len(lines) - idx)//2} remaining")


