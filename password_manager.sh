echo "パスワードマネージャーへようこそ！"
while true; do
    read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" action
    if [ "${action,,}" = "add password" ] || [ "${action,,}" = "a" ]; then
        read -p "サービス名を入力してください：" s_name
        read -p "ユーザー名を入力してください：" u_name
        read -p "パスワードを入力してください：" p_name
        echo "${s_name}:${u_name}:${p_name}" >> password.txt

        echo "パスワードの追加は成功しました。"
    elif [ "${action,,}" = "get password" ] || [ "${action,,}" = "g" ]; then
        read -p "サービス名を入力してください：" target
        while IFS=: read -r s_name u_name p_name; do
            if [ "$s_name" = "$target" ]; then
                echo "サービス名： $s_name"
                echo "ユーザー名： $u_name"
                echo "パスワード： $p_name"
                break 2
            fi
        done < password.txt
        echo "そのサービスは登録されていません。"
    elif [ "${action,,}" = "exit" ] || [ "${action,,}" = "e" ]; then
        echo "Thank you!"
        break
    else
        echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
    fi
done