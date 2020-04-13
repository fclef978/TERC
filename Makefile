# コンパイラ
COMPILER	= iverilog
# シミュレータ
SIMULATOR	= vvp
# インクルードパスの指定。これをちゃんとしておかないとDEPENDS(依存)ファイルがうまく作れない
INCLUDE		= ./src
# 生成される実行ファイル
TARGETS		= terc.vcd
# 生成されるバイナリファイルの出力ディレクトリ
TARGETDIR	= .
# ソースコードの位置
SRCROOT		= ./src
# 中間バイナリファイルの出力ディレクトリ
VVPROOT		= ./vvp
# ソースディレクトリを元にforeach命令で全cppファイルをリスト化する
SOURCES		= $(wildcard $(SRCROOT)/*.v) # $(foreach dir, $(SRCDIRS), $(wildcard $(dir)/*.v))
# 上記のcppファイルのリストを元にオブジェクトファイル名を決定
VVPS		= $(addprefix $(VVPROOT)/, $(SOURCES:.v=.vvp))

# トップレベルモジュール
ifdef target
	TOPLELVEL = $(target)
else 
	TOPLELVEL = terc
endif


# 依存ファイルを元に実行ファイルを作る
$(TARGETS): $(TOPLELVEL).vvp
	$(SIMULATOR) $(VVPROOT)/$(TOPLELVEL).vvp

$(TOPLELVEL).vvp: $(SOURCES)
	$(COMPILER) -o $(VVPROOT)/$@ -I $(SRCROOT) -s $(TOPLELVEL) $^

all: $(TARGETS)

clean: 
	rm -f $(VVPS)
