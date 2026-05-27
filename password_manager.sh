echo "パスワードマネージャーへようこそ！"
while true; do
    read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" action
    if [ "${action,,}" = "add password" ] || [ "${action,,}" = "a" ]; then
        read -r -p "サービス名を入力してください：" s_name
        read -r -p "ユーザー名を入力してください：" u_name
        read -r -p "パスワードを入力してください：" p_name
        if printf "%s%s%s" "${s_name}" "${u_name}" "${p_name}" | grep -q ":"; then
            echo "サービス名、ユーザー名、パスワードにコロンは使用できません。"
            continue
        elif [ -z "${s_name}" ] || [ -z "${u_name}" ] || [ -z "${p_name}" ]; then
            echo "サービス名、ユーザー名、パスワードは空にできません。"
            continue
        fi
        printf "%s:%s:%s\n" "${s_name}" "${u_name}" "${p_name}" >> password.txt

        echo "パスワードの追加は成功しました。"
    elif [ "${action,,}" = "get password" ] || [ "${action,,}" = "g" ]; then
        if [ ! -f password.txt ]; then
            echo "パスワードはまだ登録されていません。"
            continue
        fi
        is_registered=false #フラグの初期化
        read -r -p "サービス名を入力してください：" target
        while IFS=: read -r s_name u_name p_name; do
            if [ "${s_name}" = "${target}" ]; then
                is_registered=true #フラグの更新
                printf "サービス名：%s\n" "${s_name}"
                printf "ユーザー名：%s\n" "${u_name}"
                printf "パスワード：%s\n" "${p_name}"
                break #同じサービス名で複数登録がある場合には最初の1件のみを表示
            fi
        done < password.txt
        if [ "${is_registered}" = "false" ]; then
            echo "そのサービスは登録されていません。"
        fi
    elif [ "${action,,}" = "exit" ] || [ "${action,,}" = "e" ]; then
        echo "Thank you!"
        break
    else
        echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
    fi
done