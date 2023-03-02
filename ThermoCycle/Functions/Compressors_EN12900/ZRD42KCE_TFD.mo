within ThermoCycle.Functions.Compressors_EN12900;
function ZRD42KCE_TFD "ZRD42KCE-TFD Copeland scroll digital compressor - R407c"
  extends ThermoCycle.Functions.Compressors_EN12900.EN12900_EngUnits(
  Vs=57.17e-6,
  coef=[33042,-176.7,2.012,335.8;
471.7,-3.463,-0.00118,3.326;
-353.2,26.72,0.0266,-3.415;
6.085,0.0757,0.0000295,0.0384;
0.2325,-0.0189,-0.0000216,0.03363;
2.368,-0.1319,-0.000202,0.02782;
0.0225,0.00284,0.00000178,0.0002207;
-0.0245,-0.00369,-0.00000247,0.00002353;
-0.00987,0.00186,0.00000166,-0.0001748;
-0.007331,0.000671,0.00000129,-0.00008385]);

end ZRD42KCE_TFD;
