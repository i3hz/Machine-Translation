@echo off
rem    Run this file on the command line of an environment that contains "python" in path
rem    For example, in the terminal of your IDE
rem    Or in the correct environment of your anaconda prompt

@echo off

:: Set the default GPU (optional but good practice if you always want GPU 0)
:: You could remove the individual "set CUDA_VISIBLE_DEVICES=0 &" below if you use this line.
:: set CUDA_VISIBLE_DEVICES=0

if "%1%"=="train" (
    echo Running train with CUDA...
    set CUDA_VISIBLE_DEVICES=0 & python run.py train --train-src=./zh_en_data/train.zh --train-tgt=./zh_en_data/train.en --dev-src=./zh_en_data/dev.zh --dev-tgt=./zh_en_data/dev.en --vocab=vocab.json --cuda --lr=5e-4 --patience=1 --valid-niter=200 --batch-size=32 --dropout=.3
) else if "%1%"=="test" (
    echo Running test with CUDA...
    set CUDA_VISIBLE_DEVICES=0 & python run.py decode model.bin ./zh_en_data/test.zh ./zh_en_data/test.en outputs/test_outputs.txt --cuda
) else if "%1%"=="train_local" (
    echo Running train_local with CUDA...
    rem Added --cuda flag and CUDA_VISIBLE_DEVICES
    set CUDA_VISIBLE_DEVICES=0 & python run.py train --train-src=./zh_en_data/train.zh --train-tgt=./zh_en_data/train.en --dev-src=./zh_en_data/dev.zh --dev-tgt=./zh_en_data/dev.en --vocab=vocab.json --lr=5e-5 --cuda
) else if "%1%"=="test_local" (
    echo Running test_local with CUDA...
    rem Added --cuda flag and CUDA_VISIBLE_DEVICES
    set CUDA_VISIBLE_DEVICES=0 & python run.py decode model.bin ./zh_en_data/test.zh ./zh_en_data/test.en outputs/test_outputs.txt --cuda
) else if "%1%"=="vocab" (
    echo Running vocab generation...
    rem Vocab generation likely doesn't need CUDA
    python vocab.py --train-src=./zh_en_data/train.zh --train-tgt=./zh_en_data/train.en vocab.json
) else (
    echo Invalid Option Selected: %1%
    echo Available options: train, test, train_local, test_local, vocab
)

echo Done.