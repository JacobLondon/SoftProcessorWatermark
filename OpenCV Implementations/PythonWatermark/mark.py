# requires matplotlib and opencv
import matplotlib.pyplot as plt
import cv2, copy

"""
Requirements:
anaconda, python3
matplotlib
opencv (conda install) (opencv-python)

Info:
Image watermarking occurs with an input and watermark image.
Both images are the same size, as they are traversed simultaneously.
The watermark will be applied on the original where the alpha channel is not clear on the watermark.
"""

# open original and watermark with rgba
original = cv2.imread('image2.png', cv2.IMREAD_UNCHANGED)
watermark = cv2.imread('image3.png', cv2.IMREAD_UNCHANGED)
# copy the original to not modify it for the output
output = copy.deepcopy(original)

# make sure the images are the same size
assert len(original) == len(watermark)

# image sizes
h = original.shape[0]
w = original.shape[1]

# loop over the original pixel by pixel
for y in range(h):
    for x in range(w):
        # get rgba to check if the image is not clear at the current pixel
        w_rgba = watermark[x, y]

        # if watermark pixel has alpha data (r,g,b,a), avg the pixels
        if w_rgba[-1] != 0:
            # get rgba of original pixel so it can be averaged
            o_rgba = original[x, y]
            # average each pixel's (r,g,b,a)
            output[x, y] = [(o_rgba[i] + w_rgba[i]) / 2 for i in range(len(o_rgba))]
        

# display the watermarked image
cv2.imshow('image', output)
cv2.waitKey(0)
cv2.destroyAllWindows()
