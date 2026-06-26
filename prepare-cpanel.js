const fs = require('fs-extra');
const path = require('path');
const { execSync } = require('child_process');
const archiver = require('archiver');

async function createDeploymentPackage() {
  console.log('🚀 بدأ تحضير المشروع للرفع على cPanel...');

  const rootDir = process.cwd();
  const standaloneDir = path.join(rootDir, '.next', 'standalone');
  const deployDir = path.join(rootDir, 'cpanel_deploy');
  
  if (!fs.existsSync(standaloneDir)) {
    console.error('❌ مجلد standalone غير موجود! يرجى تشغيل npm run build أولاً.');
    process.exit(1);
  }

  // 1. Create a clean deployment folder
  if (fs.existsSync(deployDir)) {
    fs.removeSync(deployDir);
  }
  fs.mkdirSync(deployDir);

  // 2. Copy the standalone output
  console.log('📁 نسخ ملفات النظام الأساسية...');
  fs.copySync(standaloneDir, deployDir);

  // 3. Copy static files (Next.js requirement for standalone)
  console.log('📁 نسخ الملفات الثابتة (Static & Public)...');
  fs.copySync(
    path.join(rootDir, '.next', 'static'),
    path.join(deployDir, '.next', 'static')
  );
  fs.copySync(
    path.join(rootDir, 'public'),
    path.join(deployDir, 'public')
  );

  // 4. Copy Prisma folder
  console.log('📁 نسخ ملفات قاعدة البيانات (Prisma)...');
  if (fs.existsSync(path.join(rootDir, 'prisma'))) {
    fs.copySync(
      path.join(rootDir, 'prisma'),
      path.join(deployDir, 'prisma')
    );
  }

  // 5. Copy SQL dump and Instructions
  console.log('📁 نسخ ملف قاعدة البيانات وتعليمات الرفع...');
  const sqlFile = path.join(rootDir, 'current-live-database.sql');
  const instructionsFile = path.join(rootDir, 'DEPLOY-INSTRUCTIONS.md');
  
  if (fs.existsSync(sqlFile)) {
    fs.copySync(sqlFile, path.join(deployDir, 'current-live-database.sql'));
  } else {
    console.warn('⚠️ تحذير: ملف current-live-database.sql غير موجود!');
  }
  
  if (fs.existsSync(instructionsFile)) {
    fs.copySync(instructionsFile, path.join(deployDir, 'DEPLOY-INSTRUCTIONS.md'));
  }
  
  // 6. Zip the deploy folder
  console.log('📦 جاري ضغط الملفات في elsalam-cpanel-deploy.zip...');
  
  const output = fs.createWriteStream(path.join(rootDir, 'elsalam-cpanel-deploy.zip'));
  const archive = archiver('zip', { zlib: { level: 9 } });

  output.on('close', function() {
    console.log(`✅ اكتملت العملية بنجاح!`);
    console.log(`🎉 تم إنشاء ملف elsalam-cpanel-deploy.zip بحجم ${(archive.pointer() / 1024 / 1024).toFixed(2)} MB`);
    console.log('➡️ يمكنك الآن رفع هذا الملف إلى cPanel.');
  });

  archive.on('error', function(err) {
    throw err;
  });

  archive.pipe(output);
  archive.directory(deployDir, false);
  await archive.finalize();
  
  // Cleanup deploy dir
  fs.removeSync(deployDir);
}

createDeploymentPackage();
