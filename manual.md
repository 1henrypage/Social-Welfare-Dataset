Using the risk scores as ground truth for model training is a two step process. For future reference:

1. Create a new conda environment
2. Install `Python` (tested on version `3.8.0`)
3. Install dependencies from `requirements.txt`. In particular, `SDV` was problematic but version 0.17.2 does not throw warnings and its release date seems to align with the date when Lighthouse Reports declares to have completed the `synth_model.ipynb` notebook (December 28th, 2022).
4. In `synth_model.ipynb` run the 1st cell marked `###IMPORT PACKAGES###`
5. In `synth_model.ipynb` run the 15th cell marked `#NEW DATA#`
6. Install `R` (tested on version `4.4.1`)
7. Install `caret` (tested on version `6.0.94`), `gbm` (version `2.2.2`), and `dplyr` (version `1.1.4`)
8. Run the following commands in an R terminal:
   * library(caret)
   * library(gbm)
   * library(dplyr)

   * data <- read.csv("data/01_raw/[INPUT_FILENAME].csv")
   * final_model <- readRDS("data/01_raw/20220929_finale_model.rds")$model[[1]]

   * risk_scores <- predict.train(final_model, newdata = data, type = 'prob')
   * risk_scores <- cbind(data, risk_scores)
   * write.csv(risk_scores, "data/01_raw/[OUTPUT_FILENAME].csv", quote = FALSE)