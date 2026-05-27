echo "パスワードマネージャーへようこそ！"
read -p "サービス名を入力してください：" s_name
read -p "ユーザー名を入力してください：" u_name
read -p "パスワードを入力してください：" p_name
echo "${s_name}:${u_name}:${p_name}" >> password.txt
echo "Thank you!"
