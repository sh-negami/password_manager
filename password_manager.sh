echo "パスワードマネージャーへようこそ！"
while true; do
    read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" action
    if [ "${action,,}" = "add password" ] || [ "${action,,}" = "a" ]; then
        read -p "サービス名を入力してください：" s_name
        read -p "ユーザー名を入力してください：" u_name
        read -p "パスワードを入力してください：" p_name
        printf "%s:%s:%s\n" "${s_name}" "${u_name}" "${p_name}" >> password.txt

        echo "パスワードの追加は成功しました。"
    elif [ "${action,,}" = "get password" ] || [ "${action,,}" = "g" ]; then
        is_registered=false #フラグの初期化
        read -p "サービス名を入力してください：" target
        while IFS=: read -r s_name u_name p_name; do
            if [ "$s_name" = "$target" ]; then
                is_registered=true #フラグの更新
                printf "サービス名：%s\n" "$s_name"
                printf "ユーザー名：%s\n" "$u_name"
                printf "パスワード：%s\n" "$p_name"
                break #同じサービス名で複数登録がある場合には最初の1件のみを表示
            fi
        done < password.txt
        if [ "$is_registered" = false ]; then
            echo "そのサービスは登録されていません。"
        fi
    elif [ "${action,,}" = "exit" ] || [ "${action,,}" = "e" ]; then
        echo "Thank you!"
        break
    else
        echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
    fi
done