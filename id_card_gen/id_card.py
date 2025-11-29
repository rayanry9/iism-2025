from io import BytesIO
import barcode
from PIL import Image, ImageDraw, ImageFont
from barcode.writer import ImageWriter

subBarcodeFont = ImageFont.truetype('../fonts/optima-nova-lt-pro/OptimaNovaLTProDemi.otf', size=16)
nameFont = ImageFont.truetype('../fonts/neue-haas-grotesk-display-pro/NeueHaasDisplayMedium.ttf', size=40)
instituteFont = ImageFont.truetype('../fonts/optima-nova-lt-pro/OptimaNovaLTProBold.otf', size=26)
text_font = ImageFont.truetype('../fonts/optima-nova-lt-pro/OptimaNovaLTProRegular.otf', size=20)
text_value_font = ImageFont.truetype('../fonts/optima-nova-lt-pro/OptimaNovaLTProBold.otf', size=20)
top_text = ImageFont.truetype('../fonts/optima-nova-lt-pro/OptimaNovaLTProHeavy.otf', size=34)

barcodeText = "MA24BTECH11018"
blood_group = "AB+"
ph_number = "9836025700"
name = "Rayan Halder"
institute = "Hyderabad"

def get_pictogram_from_id(id: int):
    match id:
        case 5 | 19:
            return "../schedule_gen/Pictograms/Cricket.png"
        case 6 :
            return "../schedule_gen/Pictograms/Hockey.png"
        case 7 | 20:
            return "../schedule_gen/Pictograms/Football.png"
        case 14 | 15 | 25:
            return "../schedule_gen/Pictograms/Volleyball.png"
        case _:
            return "../schedule_gen/Pictograms/Running.png"

with open('./data.csv', "r") as data:
    lines = data.readlines()
    for idx in range(len(lines)):
        data = lines[idx].split(",")
        with Image.open('./ID_Student_Front.png') as bg:
            # barcode 
            rv = BytesIO()
            draw = ImageDraw.Draw(bg)
            barcode.Code128(barcodeText, writer=ImageWriter()).write(rv, text='')
            bc = Image.open(rv)

            barcode_width = 285
            bc = bc.resize((barcode_width, 48), Image.Resampling.LANCZOS)
            bg.paste(bc, (100,633), None)

            # barcode subtext
            x,y = 100 + (barcode_width-draw.textlength(barcodeText, font=subBarcodeFont)-(len(barcodeText)-1)*4)/2,690
            for char in barcodeText:
                draw.text((x,y), char,fill='#232323', font=subBarcodeFont)
                x+= draw.textlength(char, font=subBarcodeFont) + 4

            # institute
            draw.text((30,260*2),"IIT "+institute.upper(), fill='#232323', font=instituteFont)

            # blood group
            draw.text((30,281*2),"Blood Group - ", fill='#232323', font=text_font)
            draw.text((30+draw.textlength("Blood Group - ", font=text_font),281*2),blood_group, fill='#232323', font=text_value_font)

            # phone number
            draw.text((30,296*2),"Ph. Number - ", fill='#232323', font=text_font)
            draw.text((30+draw.textlength("Ph. Number - ", font=text_font),296*2), ph_number, fill='#232323', font=text_value_font)

            # name
            splited_name = name.split(" ")
            draw.text((30, 430)," ".join(splited_name[0:len(splited_name)-1]), font=nameFont, fill="#232323")
            draw.text((30, 430+40), splited_name[len(splited_name)-1], font=nameFont, fill='#232323')

            # pictogram
            pictogram = Image.open(get_pictogram_from_id(5)).convert("RGBA").resize((144,144), Image.Resampling.LANCZOS)
            bg.paste(pictogram, (155*2, 215*2), pictogram)

            # top text 
            draw.text((227*2 - draw.textlength(data[3].upper(), font=top_text), 31*2), data[3].upper(), fill='#EF4823', font=top_text)

             

            # display
            bg.show()
