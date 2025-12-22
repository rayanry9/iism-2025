from io import BytesIO
import os
import barcode
from PIL import Image, ImageDraw, ImageFont
from barcode.writer import ImageWriter

subBarcodeFont = ImageFont.truetype('../fonts/optima-nova-lt-pro/OptimaNovaLTProDemi.otf', size=16*2)
nameFont = ImageFont.truetype('../fonts/neue-haas-grotesk-display-pro/NeueHaasDisplayMedium.ttf', size=40*2)
instituteFont = ImageFont.truetype('../fonts/optima-nova-lt-pro/OptimaNovaLTProBold.otf', size=26*2)
text_font = ImageFont.truetype('../fonts/optima-nova-lt-pro/OptimaNovaLTProRegular.otf', size=20*2)
text_value_font = ImageFont.truetype('../fonts/optima-nova-lt-pro/OptimaNovaLTProBold.otf', size=20*2)
top_text = ImageFont.truetype('../fonts/optima-nova-lt-pro/OptimaNovaLTProHeavy.otf', size=34*2)

photos_folder = "images/users/original"
output_folder = "final_ids"
pictogram_folder = "../schedule_gen/Pictograms/"

def get_pictogram_from_id(id: int):
    match id:
        case 16 | 17:
            return "Badminton"
        case 18:
            return "Basketball"
        case 21:
            return "Squash"
        case 22:
            return "Tennis"
        case 23|24:
            return "TableTennis"
        case 5 | 19:
            return "Cricket"
        case 6 :
            return "Hockey"
        case 7 | 20:
            return "Football"
        case 14 | 15 | 25:
            return "Volleyball"
        case 27|28|29|30|31|32|45|46|47|48|49|60|61|62|63|64|65|66|67|68|76|77|78:
            return "Running"
        case 33|34|50:
            return "Hurdle"
        case 35|36|51|52|58|69|79:
            return "Relay"
        case 37|53|70:
            return "HighJump"
        case 38|54|71|80:
            return "LongJump"
        case 39:
            return "TripleJump"
        case 59:
            return "Chess"
        case 40:
            return "PoleVault"
        case 41|55|73|81:
            return "ShotPut"
        case 42|56|74|82:
            return "DiscussThrow"
        case 43|57|75|83:
            return "JavelinThrow"
        case 44|72:
            return "HammerThrow"
        case _ :
            return "Running"

def make_circle_avatar(img, diameter):
    """Return a clean circular avatar with NO border."""
    img = img.convert("RGBA")
    img = img.crop(img.getbbox())
    w, h = img.size
    side = min(w, h)

    # Center crop to square
    left = (w - side) // 2
    top = (h - side) // 2
    img = img.crop((left, top, left + side, top + side))
    img = img.resize((diameter, diameter), Image.Resampling.LANCZOS)

    # Create circle mask
    mask = Image.new("L", (diameter, diameter), 0)
    draw = ImageDraw.Draw(mask)
    draw.ellipse((0, 0, diameter - 1, diameter - 1), fill=255)

    # Apply mask (circle crop)
    avatar = Image.new("RGBA", (diameter, diameter), (0, 0, 0, 0))
    avatar.paste(img, (0, 0), mask)

    return avatar

with open('./data-staff-id.csv', "r") as data:
    lines = data.readlines()
    for idx in range(len(lines)):
        if idx ==0 :
            continue
        data = lines[idx].split(",")

        name = str(data[0]).strip(" ")
        institute = data[1].strip(" ")
        blood_group = data[2].strip(" ")
        ph_number = data[3].strip(" ")
        sport = data[4]
        role = data[5].strip(" ")
        barcodeText = data[7].strip(" ")
        photo = data[8].strip(" \n")

        with Image.open('./ID_Staff_Front.png') as bg:
            # barcode 
            rv = BytesIO()
            draw = ImageDraw.Draw(bg)
            barcode.Code128(barcodeText, writer=ImageWriter()).write(rv, text='')
            bc = Image.open(rv)

            barcode_width = 285*2
            bc = bc.resize((barcode_width, 48*2), Image.Resampling.LANCZOS)
            bg.paste(bc, (100*2,633*2), None)

            # barcode subtext
            x,y = 100*2 + (barcode_width-draw.textlength(barcodeText, font=subBarcodeFont)-(len(barcodeText)-1)*8)/2,690*2
            for char in barcodeText:
                draw.text((x,y), char,fill='#232323', font=subBarcodeFont)
                x+= draw.textlength(char, font=subBarcodeFont) + 8

            # institute
            draw.text((30*2,260*4),"IIT "+institute.upper(), fill='#232323', font=instituteFont)

            # blood group
            draw.text((30*2,281*4),"Blood Group - ", fill='#232323', font=text_font)
            draw.text((30*2+draw.textlength("Blood Group - ", font=text_font),281*4),blood_group, fill='#232323', font=text_value_font)

            # phone number
            draw.text((30*2,296*4),"Ph. Number - ", fill='#232323', font=text_font)
            draw.text((30*2+draw.textlength("Ph. Number - ", font=text_font),296*4), ph_number, fill='#232323', font=text_value_font)

            # name
            splited_name = name.split(" ")
            for i in range(len(splited_name)):
                splited_name[i] = splited_name[i].capitalize()
            if len(splited_name) == 1:
                draw.text((30*2, 450*2),splited_name[0], font=nameFont, fill="#232323")
            else:
                draw.text((30*2, 430*2)," ".join(splited_name[:len(splited_name)-1]), font=nameFont, fill="#232323")
                draw.text((30*2, 470*2), splited_name[len(splited_name)-1], font=nameFont, fill='#232323')

            # pictogram
            if sport != '':
                pictogram = Image.open(pictogram_folder+get_pictogram_from_id(int(sport))+".png").convert("RGBA").resize((144*2,144*2), Image.Resampling.LANCZOS)
                bg.paste(pictogram, (155*4, 215*4), pictogram)

            # top text 
            draw.text((227*4 - draw.textlength(data[5].upper(), font=top_text), 31*4), data[5].upper(), fill='#EF4823', font=top_text)


            photo_path = photos_folder+"/"+photo+".png"
            if photo_path and os.path.exists(photo_path):
                try:
                    pimg = Image.open(photo_path).convert("RGBA")
                except:
                    pimg = None
            else:
                pimg = None

            # if no photo, use placeholder solid circle (orange)
            if pimg is None:
                placeholder = Image.new("RGBA", (105*4, 105*4), (200,200,200))
                avatar = make_circle_avatar(placeholder, 105*4)
            else:
                avatar = make_circle_avatar(pimg, 105*4)

            # compute paste location for avatar (top center area)
            bg.paste(avatar, (134*2, 130*2), avatar)

             
            save_name = f"{barcodeText or name.replace(' ','_')}.png"
            out_path = os.path.join(output_folder,"IIT "+institute,save_name)
            os.makedirs(os.path.join(output_folder,"IIT "+institute), exist_ok=True)

            print(f'Saved {out_path}')

            # display
            bg.save(out_path)
