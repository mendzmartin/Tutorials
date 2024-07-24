# How to deploy de documentation of a project

The best tool I know for that is LiveServer and its servedocs() function. Just do:

```bash
    @prompt$: cd my_directory/MyPackage.jl/
    @MyPackage.jl$: julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.9.0 (2023-05-07)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |
```
```julia
    julia> using Pkg
    julia> Pkg.activate("docs")
    julia> Pkg.add("Documenter")
    julia> Pkg.develop(path="../MyPackage.jl")
    julia> servedocs()
└ @ Documenter ~/.julia/packages/Documenter/qoyeC/src/deployconfig.jl:76
✓ LiveServer listening on http://localhost:8000/ ...
  (use CTRL+C to shut down)
```

and the docs will be rendered and hosted locally at the url provided in the output.

# References
+ [https://m3g.github.io/JuliaNotes.jl/stable/publish_docs/](https://m3g.github.io/JuliaNotes.jl/stable/publish_docs/)

## Use `DocumenterTools` to generate the keys

```julia
import DocumenterTools
DocumenterTools.genkeys()
```

which will output something like:

```julia-repl
julia> DocumenterTools.genkeys()
[ Info: add the public key below to https://github.com/$USER/$REPO/settings/keys with read/write access:

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIIDDRX8DyLG... CCKQPTNei1Ng8b5d+a1ldnVSkgB0= Documenter

[ Info: add a secure environment variable named 'DOCUMENTER_KEY' to https://travis-ci.com/$USER/$REPO/settings (if you deploy using Travis CI) or https://github.com/$USER/$REPO/settings/secrets (if you deploy using GitHub Actions) with value:

LS0tLS1CRUdJTiBPUEVOU1NIIFBSSV... MGtyNng2VWR6WTFxckg1bkUyVGU2ajU3TUdveXpZL1EzTApoNGlqbE5NSWJTOFA2K2JNUkYxVFVCUzdQbC9mZDlTZWJKYTlKdWpMamtnNWRiblJFSkpESmpDTzNzSjZ4d0VCUmV2WmJSCnZtV2lkWkVnQnlPUFVsQUFBQUNrUnZZM1Z0Wlc1MFpYST0KLS0tLS1FTkQgT1BFTlNTSCBQUklWQVRFIEtFWS0tLS0tCg==
```

### Add the keys to the github repository

The first key, starting with `ssh-rsa ` must be copied as a new "Deploy key` in the project, at: 

`Settings -> Deploy keys -> Add deploy key`

Be careful in allowing `Write permissions`. The second key has to be copied to:

`Settings -> Secrets -> Actions -> New repository secret` 

with the name `DOCUMENTER_KEY`.

## Add the GithubActions (ci.yml) workflow file

Create, in your project, a file 
```
/home/user/.julia/dev/Project/.github/workflows/ci.yml
```
with a content similar to [THIS](https://github.com/m3g/CellListMap.jl/blob/main/.github/workflows/ci.yml) one.

Note that you have to change some lines that contain the name of the
package name (in the example the package is called `CellListMap` - two substitutions are required).

## Create a release

Go to the github page. Go to `Releases` $\rightarrow$ `Draft a new Release`. Create a new tag for the new version (for example, `v0.2.0`) or a tag only for deploying the documentation (for example, `v0.1.0+doc1`). That will trigger the execution of the CI run and, hopefully, build the docs and the `gh-branch` that contain the docs automatically. 

The pages will be hosted at, for example:

[https://m3g.github.io/JuliaNotes.jl/stable/](https://m3g.github.io/JuliaNotes.jl/stable/)

You can also update the docs just by uploading a new tag, with:

```
git tag -a v0.1.0+doc2 -m "v0.1.0"
git push --tag
```

## Create an empty gh-pages branch and choose it to deploy the page

I have seen these steps happening automatically after the tag is created. If not, follow the steps below. 

Create a branch on the repository called `gh-pages` using: 

```
git checkout --orphan gh-pages
git reset --hard
git commit --allow-empty -m "Initializing gh-pages branch"
git push origin gh-pages
git checkout main
```

In the GitHub repository, do:

```
Settings -> GitHub Pages -> choose gh-pages (/root)
```

(that is, go to Settings, scroll down, on the GitHub pages section, choose the `gh-pages` branch to deploy your page).

After the end of the CI run, if no error was detected, the site should be published.

## For a registered package

In this case, you might want `TagBot` to tag and release automatically the documentation of new versions:

### Create the `TagBot.yml` file

```
/home/user/.julia/dev/Project/.github/workflows/TagBot.yml
```
and add the content provided here: [TagBot.yml example](https://github.com/JuliaRegistries/TagBot/blob/master/README.md)

### Deployment of the docs of a previous version

I went to the registered commit, which always have the following information, for example:

```
git tag -a v0.4.11 -m "<description of version>" fbeec6a00adbd15053d297542e8354c457b2a610
git push origin v0.4.11
```

and created a new tag adding `+doc1` to the tag:

```
git tag -a v0.4.11+doc1 -m "v0.4.11" fbeec6a00adbd15053d297542e8354c457b2a610
git push origin v0.4.11+doc1
```

Then I had to go to the github page -> tags, and publish that release manually.

Further discussion:
[Latest version of docs not published](https://discourse.julialang.org/t/latest-version-of-docs-not-published-github-actions-tagbot/50634/1)