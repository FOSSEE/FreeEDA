sourceProject=IC555AstableMultivibrator
targetProject=frequencyDivider
cp -r $sourceProject $targetProject
cd $targetProject
mv $sourceProject.bak $targetProject.bak
mv $sourceProject-cache.bak $targetProject-cache.bak
mv $sourceProject-cache.lib $targetProject-cache.lib
mv $sourceProject.cir $targetProject.cir
mv $sourceProject.cir.ckt $targetProject.cir.ckt
mv $sourceProject.cir.out $targetProject.cir.out
mv $sourceProject.pro $targetProject.pro
mv $sourceProject.proj $targetProject.proj
mv $sourceProject.sch $targetProject.sch

