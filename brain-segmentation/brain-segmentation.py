import pickle
import numpy as np
import nibabel as nib
import matplotlib.pyplot as plt
from dipy.segment.mask import median_otsu
from dipy.core.histeq import histeq

img = pickle.load(open('siemens_scil_b0', 'rb'))
data = np.squeeze(img.get_data())

b0_mask, mask = median_otsu(data, 2, 1)
mask_img = nib.Nifti1Image(mask.astype(np.float32), img.get_affine())
b0_img = nib.Nifti1Image(b0_mask.astype(np.float32), img.get_affine())

fname = 'se_1.5t'
nib.save(mask_img, fname + '_binary_mask.nii.gz')
nib.save(b0_img, fname + '_mask.nii.gz')

## visualizing the results
sli = data.shape[2] / 2
plt.figure('Brain segmentation')
plt.subplot(1, 2, 1).set_axis_off()
plt.imshow(histeq(data[:, :, sli].astype('float')).T,
           cmap='gray', origin='lower')

plt.subplot(1, 2, 2).set_axis_off()
plt.imshow(histeq(b0_mask[:, :, sli].astype('float')).T,
           cmap='gray', origin='lower')

plt.savefig('median_otsu.png')
