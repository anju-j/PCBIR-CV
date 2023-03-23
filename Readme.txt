code/dataset_combined comprises:

Combined feature vectors of images in Corel-10k (URL: http://www.ci.gxnu.edu.cn/cbir/Dataset.aspx. Accessed on 1 Jan 2019) datasets

5 MPEG-7 visual descriptors (Cited as: Manjunath, B.S., Ohm, J.R., Vasudevan, V.V., Yamada, A., 2001. Color and texture descriptors. IEEE Transactions on circuits and systems for video technology 11, 703–715):
    Color Structure Descriptor (CSD)
    Scalable Color Descriptor (SCD)
    Color Layout Descriptor (CLD)
    Edge Histogram Descriptor (EHD) and 
    Dominant Color Descriptor (DCD)

The features are extracted using MPEG-7 Low Level Feature Extraction Library in the article: Muhammet Bastan, Hayati Cam, Ugur Gudukbay and Ozgur Ulusoy, "BilVideo-7: An MPEG-7 Compatible Video Indexing and Retrieval System", IEEE MultiMedia, vol. 17, no. 3, pp. 62-73, July-September 2010. Then, two feature vectors are fused together for generating modified feature descriptor.

Indexing uses Locality Sensitive Hashing (LSH) on modified feature descriptors. LSH implementation is obtained from site: https://home.ttic.edu/~gregory/download.html 

Image features encrypted using Asymmetric Scalar Product-preserving Encryption (ASPE) (Cited as: Wong, W.K., Cheung, D.W.L., Kao, B. and Mamoulis, N., 2009, June. Secure kNN computation on encrypted databases. In Proceedings of the 2009 ACM SIGMOD International Conference on Management of data (pp. 139-152).) are used for ranking retrieved results.
    
