function run
    docker run --rm -it -v (pwd):/work -w /work $argv
end
