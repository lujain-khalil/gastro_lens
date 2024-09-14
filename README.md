# On-Edge Deployment of Vision Transformers for Medical Diagnostics Using the Kvasir-Capsule Dataset
_Dara Varam, Lujain Khalil, and Dr. Tamer Shanableh_

This repository contains the necessary code for developing an Android application suitable for model deployment.

This is the official Flutter implementation of our paper, ["On-Edge Deployment of Vision Transformers for Medical Diagnostics: A Study on the Kvasir-Capsule Dataset"](https://www.mdpi.com/2076-3417/14/18/8115), published in MDPI Applied Sciences (10th September, 2024).

Details of our Keras implementation can be accessed here: [https://github.com/DaraVaram/Lightweight-ViTs-for-Medical-Diagnostics](https://github.com/DaraVaram/Lightweight-ViTs-for-Medical-Diagnostics).

![image](https://github.com/user-attachments/assets/aff3d0dc-4488-4323-babc-ae2cdd063fdf)

## User Interface
### Home screen and Drawer
![image](https://github.com/user-attachments/assets/c86f67df-5be7-442a-9677-73a3d1c60930)

### Classification scenarios at image uploads
![image](https://github.com/user-attachments/assets/7a317085-6309-4c77-ada2-3ba55c90f64a)
(a) An image is uploaded and classified correctly by the model. 
(b) An image is uploaded and classified incorrectly by the model. The user can choose the correct class from a drop-down menu.

### Report screen
![image](https://github.com/user-attachments/assets/39081047-0f32-4aad-9db9-ea67b1c2cb19)

## BibTeX Citation
MDPI paper citation
```
@Article{app14188115,
AUTHOR = {Varam, Dara and Khalil, Lujain and Shanableh, Tamer},
TITLE = {On-Edge Deployment of Vision Transformers for Medical Diagnostics Using the Kvasir-Capsule Dataset},
JOURNAL = {Applied Sciences},
VOLUME = {14},
YEAR = {2024},
NUMBER = {18},
ARTICLE-NUMBER = {8115},
URL = {https://www.mdpi.com/2076-3417/14/18/8115},
ISSN = {2076-3417},
ABSTRACT = {This paper aims to explore the possibility of utilizing vision transformers (ViTs) for on-edge medical diagnostics by experimenting with the Kvasir-Capsule image classification dataset, a large-scale image dataset of gastrointestinal diseases. Quantization techniques made available through TensorFlow Lite (TFLite), including post-training float-16 (F16) quantization and quantization-aware training (QAT), are applied to achieve reductions in model size, without compromising performance. The seven ViT models selected for this study are EfficientFormerV2S2, EfficientViT_B0, EfficientViT_M4, MobileViT_V2_050, MobileViT_V2_100, MobileViT_V2_175, and RepViT_M11. Three metrics are considered when analyzing a model: (i) F1-score, (ii) model size, and (iii) performance-to-size ratio, where performance is the F1-score and size is the model size in megabytes (MB). In terms of F1-score, we show that MobileViT_V2_175 with F16 quantization outperforms all other models with an F1-score of 0.9534. On the other hand, MobileViT_V2_050 trained using QAT was scaled down to a model size of 1.70 MB, making it the smallest model amongst the variations this paper examined. MobileViT_V2_050 also achieved the highest performance-to-size ratio of 41.25. Despite preferring smaller models for latency and memory concerns, medical diagnostics cannot afford poor-performing models. We conclude that MobileViT_V2_175 with F16 quantization is our best-performing model, with a small size of 27.47 MB, providing a benchmark for lightweight models on the Kvasir-Capsule dataset.},
DOI = {10.3390/app14188115}
}
```
Full Kvasir-Capsule dataset available here: [https://datasets.simula.no/kvasir-capsule/](https://datasets.simula.no/kvasir-capsule/).
```
@article{Smedsrud2021,
  title = {{Kvasir-Capsule, a video capsule endoscopy dataset}},
  author = {
    Smedsrud, Pia H and Thambawita, Vajira and Hicks, Steven A and
    Gjestang, Henrik and Nedrejord, Oda Olsen and N{\ae}ss, Espen and
    Borgli, Hanna and Jha, Debesh and Berstad, Tor Jan Derek and
    Eskeland, Sigrun L and Lux, Mathias and Espeland, H{\aa}vard and
    Petlund, Andreas and Nguyen, Duc Tien Dang and Garcia-Ceja, Enrique and
    Johansen, Dag and Schmidt, Peter T and Toth, Ervin and
    Hammer, Hugo L and de Lange, Thomas and Riegler, Michael A and
    Halvorsen, P{\aa}l
  },
  doi = {10.1038/s41597-021-00920-z},
  journal = {Scientific Data},
  number = {1},
  pages = {142},
  volume = {8},
  year = {2021}
}
```
