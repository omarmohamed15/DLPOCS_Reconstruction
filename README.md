Unsupervised deep learning for 3D interpolation of highly incomplete data


We propose to denoise and reconstruct the 3D seismic data simultaneously using an unsupervised deep learning framework, which does not require any prior information about the seismic data and is free of labels.
We use an iterative process to reconstruct the 3D highly incomplete seismic data. For each iteration, we utilize the deep learning framework to denoise the 3D seismic data and initially reconstruct the missing traces.
Then, the projection onto convex sets (POCS) algorithm is utilized for further enhancement of the seismic data reconstruction. The output of the POCS is considered as the input for the deep learning network in the next iteration. 
We use a patching technique to extract 3D seismic patches. Since the proposed deep learning network consists of several fully connected layers, each extracted patch needs to be converted to a 1D vector. Besides, we utilize an attention mechanism to enhance the learning capability of the proposed deep learning network. We evaluate the performance of the proposed framework using several synthetic and field examples and find that the proposed method outperforms all benchmark methods.

How to Run:

1- Run DenseNet3D.m to reconstruct the 3D seismic data.

2- Run SConstruct to plot the results.

## Reference

Saad, Omar M., Sergey Fomel, Raymond Abma, and Yangkang Chen. "Unsupervised deep learning for 3D interpolation of highly incomplete data." Geophysics 88, no. 1 (2022): WA189-WA200.

BibTeX:

          @article{DLPOCS2023,
            title={Unsupervised deep learning for 3D interpolation of highly incomplete data},
            author={Saad, Omar M and Fomel, Sergey and Abma, Raymond and Chen, Yangkang},
            journal={Geophysics},
            volume={88},
            number={1},
            pages={WA189--WA200},
            year={2022},
            publisher={Society of Exploration Geophysicists and American Association of Petroleum}
          }
-----------
