$stack=$args[0]
$environment=$args[1]
$file_environment="environment/environment.${environment}.ps1"
echo "getting environment from file ${file_environment}"
. $file_environment

echo "packaging $stack $environment"
cd "$stack/scripts"
.\package.ps1
