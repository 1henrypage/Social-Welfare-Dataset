using CSV
using DataFrames

function parse_threshold(filename::String; threshold::Float64=0.6970136,
                         label_col::Symbol=:checked, drop_scores::Bool=false)
    # Read synthetic data
    data = DataFrame(CSV.File(filename))
    # Convert risk score to label based on the provided threshold
    # 0.6970136 corresponds to the "threshold derived from training data risk score distribution"
    # i.e., if label Ja ("Yes fraud") is larger than threshold this qualifies as high risk
    # Predicting "No" has expected accuracy of ~85% 
    data[!, label_col] = data[!, :Ja] .> threshold
    # Remove risk score columns
    if drop_scores
        targets = [:Ja, :Nee]
        data = DataFrames.select!(data, Not(targets))
    end

    out_file = split(filename, ".")[1]
    CSV.write("$(out_file)_checked.csv", data)
    return data
end