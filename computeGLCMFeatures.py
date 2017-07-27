import itk, sys

clock = itk.TimeProbe()

if len(sys.argv) != 6:
  print("Usage: " + sys.argv[0] + " <inputImagePath> "
        " <NumberOfBinsPerAxis> <PixelValueMin> "
        "<PixelValueMax> <NeighborhoodRadius>")
  sys.exit(1)

for i in range(10):
    
  clock.Start()
        
  im = itk.imread(sys.argv[1])
  filtr = itk.CoocurrenceTextureFeaturesImageFilter.New(im)
  filtr.SetNumberOfBinsPerAxis(int(sys.argv[2]))
  filtr.SetPixelValueMinMax(int(sys.argv[3]), int(sys.argv[4]))
  filtr.SetNeighborhoodRadius(int(sys.argv[5]))
  result = filtr.GetOutput()
  itk.imwrite(result, "result.nrrd")
                                    
  clock.Stop()
  print('Mean: ' + str(clock.GetMean()))
  print('Total: ' + str(clock.GetTotal()))


clock.Report()