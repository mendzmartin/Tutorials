# Activation of Julia's multithreading on VSCode

## The quick fix (no details explaining stuff)

I clicked the "Edit in settings.json" link under "Julia: Num Threads", and then added the lines,

```
    "julia.NumThreads": 12,
    "settingsSync.ignoredSettings": [
        "-julia.NumThreads"
    ],
```

between the first and last curly braces (ie, the outermost curly braces, `{ ... }`.

## The longer answer
### Determining the number of threads on your CPU

I like to manually set the number of threads for hardware specific constraints, so I needed to determine what my max number of CPU threads was. To do this, I opened up PowerShell and typed in `wmic cpu get name`, and then got a result of

```
    Name
    Intel(R) Core(TM) i7-10750H CPU @ 2.60GHz
```

I copied this into a search engine, and clicked on a link from a webpage on Intel.com that was titled the same as the name of the processor. There was a section on the page titled "CPU Specifications" that had "Total Threads" listed as `12`.

### Example of settings.json file and a basic overview of JSON syntax

#### Example

So the `settings.json` file should look something like,

```
{
    // There will probably be some other VS Code settings with a layout similar to 
    "nameOfFeatureInVSCode.specificSetting": true,

    // You might also see stuff with a list of values like
    "nameOfOtherFeature.settingThatCanUseMultipleValues": [
        "FirstStringSetting",
        "SecondStringSetting"
    ],

   // And all you need to do is add these lines
    "julia.NumThreads": 12,
    "settingsSync.ignoredSettings": [
        "-julia.NumThreads"
    ],

}
```

#### Basic overview of JSON

Note that the thing following the colon (`: <value>`) could be a boolean value, string, integer, or other data types depending on the particular setting.

If you're coming from Python, you'll notice the JSON syntax is like the syntax for dictionaries in Python in which there are key-value pairs. So, like Python dicts, the key is on the left side of the colon, the value is on the right side of the colon, and the value can be a list of data values.



## Starting Julia with multiple threads

To check the thread's configuration use the command
```julia
    julia> Threads.nthreads()
    12
```

And if we want run some `*,jl` code we need to run from BASH SHELL (or any other terminal) the next: `@prompt$ julia -t 12` where the number 12 means that we want to run our parallel code with 12 threads.

## References:
+ [https://stackoverflow.com/questions/71596187/changing-threads-in-settings-json-of-vs-code-for-julias-jupyter-notebooks/71826561#71826561](https://stackoverflow.com/questions/71596187/changing-threads-in-settings-json-of-vs-code-for-julias-jupyter-notebooks/71826561#71826561)
+ [https://docs.julialang.org/en/v1/manual/multi-threading/](https://docs.julialang.org/en/v1/manual/multi-threading/)