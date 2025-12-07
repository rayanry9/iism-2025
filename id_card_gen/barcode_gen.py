from io import BytesIO 
import os 
import barcode 
from barcode.writer import ImageWriter 
from PIL import Image, ImageDraw, ImageFont 
output_folder = "barcodes" 
# output folder 
os.makedirs(output_folder, exist_ok=True) 
subBarcodeFont = ImageFont.truetype('../fonts/optima-nova-lt-pro/OptimaNovaLTProDemi.otf', size=28) 
with open('./barcode.txt', "r") as file: 
    lines = file.readlines() 
    for idx in range(len(lines)): 
        barcodeText = lines[idx].upper().strip(' \n') 
        print(barcodeText) 
        rv = BytesIO() 
        img = Image.new('RGBA', (2*220, 2*60), None) 
        draw = ImageDraw.Draw(img) 

        barcode.Code128(barcodeText, writer=ImageWriter()).write(rv, text='', options={"foreground": "black", "background": "#111111"}) 
        bc = Image.open(rv).convert('RGBA')
        barcode_width = 2*220 

        datas = bc.getdata()

        remove_color = (17, 17, 17)  # the color to remove

        new_data = []
        for r, g, b, a in datas:
            if (r, g, b) == remove_color:
                new_data.append((r, g, b, 0))  # make transparent
            else:
                new_data.append((r, g, b, a))

        bc.putdata(new_data)

        bc = bc.resize((barcode_width, 2*38), Image.Resampling.LANCZOS) 
        img.paste(bc, (0,0), None) 

        x,y = (barcode_width-draw.textlength(barcodeText, font=subBarcodeFont)-(len(barcodeText)-1)*8)/2,2*46 
        for char in barcodeText: 
            draw.text((x,y), char,fill='#000000', font=subBarcodeFont) 
            x+= draw.textlength(char, font=subBarcodeFont) + 8 


        img.save(output_folder+"/"+barcodeText+".png")
