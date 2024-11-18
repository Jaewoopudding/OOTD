#!/bin/bash

# 원본 디렉토리
SOURCE_DIR="/home/taeyoung/jaewoo/OOTD/results"

# 새 디렉토리
TARGET_DIR="/home/taeyoung/jaewoo/OOTD/models"

# 복사할 파일 이름 패턴 (공백으로 구분)
FILES_TO_COPY=("model-100000.pt" "config.gin")

# 새로운 구조 생성 및 파일 복사
for FILE_PATTERN in "${FILES_TO_COPY[@]}"; do
    find "$SOURCE_DIR" -type f -name "$FILE_PATTERN" | while read -r FILE; do
        # 원본 파일 경로에서 상대 경로 계산
        RELATIVE_PATH="${FILE#$SOURCE_DIR/}"
        # 타겟 경로 계산
        TARGET_PATH="$TARGET_DIR/$(dirname "$RELATIVE_PATH")"
        # 타겟 경로 생성
        mkdir -p "$TARGET_PATH"
        # 파일 복사
        cp "$FILE" "$TARGET_PATH/"
    done
done

echo "새로운 구조가 $TARGET_DIR 에 생성되었습니다."