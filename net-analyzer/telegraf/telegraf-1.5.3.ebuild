# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/influxdata/telegraf"
EGO_VENDOR=(
	"collectd.org 2ce144541b8903101fb8f1483cc0497a68798122 github.com/collectd/go-collectd"
	"github.com/aerospike/aerospike-client-go 95e1ad7791bdbca44707fedbb29be42024900d9c"
	"github.com/amir/raidman c74861fe6a7bb8ede0a010ce4485bdbb4fc4c985"
	"github.com/apache/thrift 4aaa92ece8503a6da9bc6701604f69acf2b99d07"
	"github.com/aws/aws-sdk-go c861d27d0304a79f727e9a8a4e2ac1e74602fdc0"
	"github.com/beorn7/perks 4c0e84591b9aa9e6dcfdf3e020114cd81f89d5f9"
	"github.com/bsm/sarama-cluster abf039439f66c1ce78017f560b490612552f6472"
	"github.com/cenkalti/backoff b02f2bbce11d7ea6b97f282ef1771b0fe2f65ef3"
	"github.com/couchbase/go-couchbase bfe555a140d53dc1adf390f1a1d4b0fd4ceadb28"
	"github.com/couchbase/gomemcached 4a25d2f4e1dea9ea7dd76dfd943407abf9b07d29"
	"github.com/couchbase/goutils 5823a0cbaaa9008406021dc5daf80125ea30bba6"
	"github.com/davecgh/go-spew 346938d642f2ec3594ed81d874461961cd0faa76"
	"github.com/dgrijalva/jwt-go dbeaa9332f19a944acb5736b4456cfcc02140e29"
	"github.com/docker/docker f5ec1e2936dcbe7b5001c2b817188b095c700c27"
	"github.com/docker/go-connections 990a1a1a70b0da4c4cb70e117971a4f0babfbf1a"
	"github.com/eapache/go-resiliency b86b1ec0dd4209a588dc1285cdd471e73525c0b3"
	"github.com/eapache/go-xerial-snappy bb955e01b9346ac19dc29eb16586c90ded99a98c"
	"github.com/eapache/queue 44cc805cf13205b55f69e14bcb69867d1ae92f98"
	"github.com/eclipse/paho.mqtt.golang d4f545eb108a2d19f9b1a735689dbfb719bc21fb"
	"github.com/go-logfmt/logfmt 390ab7935ee28ec6b286364bba9b4dd6410cb3d5"
	"github.com/go-sql-driver/mysql 2e00b5cd70399450106cec6431c2e2ce3cae5034"
	"github.com/gobwas/glob bea32b9cd2d6f55753d94a28e959b13f0244797a"
	"github.com/go-ini/ini 9144852efba7c4daf409943ee90767da62d55438"
	"github.com/gogo/protobuf 7b6c6391c4ff245962047fc1e2c6e08b1cdfa0e8"
	"github.com/golang/protobuf 8ee79997227bf9b34611aee7946ae64735e6fd93"
	"github.com/golang/snappy 7db9049039a047d955fe8c19b83c8ff5abd765c7"
	"github.com/go-ole/go-ole be49f7c07711fcb603cff39e1de7c67926dc0ba7"
	"github.com/google/go-cmp f94e52cad91c65a63acc1e75d4be223ea22e99bc"
	"github.com/gorilla/mux 392c28fe23e1c45ddba891b0320b3b5df220beea"
	"github.com/go-sql-driver/mysql 2e00b5cd70399450106cec6431c2e2ce3cae5034"
	"github.com/hailocab/go-hostpool e80d13ce29ede4452c43dea11e79b9bc8a15b478"
	"github.com/hashicorp/consul 63d2fc68239b996096a1c55a0d4b400ea4c2583f"
	"github.com/influxdata/tail a395bf99fe07c233f41fba0735fa2b13b58588ea"
	"github.com/influxdata/toml 5d1d907f22ead1cd47adde17ceec5bda9cacaf8f"
	"github.com/influxdata/wlog 7c63b0a71ef8300adc255344d275e10e5c3a71ec"
	"github.com/jackc/pgx 63f58fd32edb5684b9e9f4cfaac847c6b42b3917"
	"github.com/jmespath/go-jmespath bd40a432e4c76585ef6b72d3fd96fb9b6dc7b68d"
	"github.com/kardianos/osext c2c54e542fb797ad986b31721e1baedf214ca413"
	"github.com/kardianos/service 6d3a0ee7d3425d9d835debc51a0ca1ffa28f4893"
	"github.com/kballard/go-shellquote d8ec1a69a250a17bb0e419c386eac1f3711dc142"
	"github.com/matttproud/golang_protobuf_extensions c12348ce28de40eed0136aa2b644d0ee0650e56c"
	"github.com/Microsoft/go-winio ce2922f643c8fd76b46cadc7f404a06282678b34"
	"github.com/miekg/dns 99f84ae56e75126dd77e5de4fae2ea034a468ca1"
	"github.com/mitchellh/mapstructure d0303fe809921458f417bcf828397a65db30a7e4"
	"github.com/multiplay/go-ts3 07477f49b8dfa3ada231afc7b7b17617d42afe8e"
	"github.com/naoina/go-stringutil 6b638e95a32d0c1131db0e7fe83775cbea4a0d0b"
	"github.com/nats-io/go-nats ea9585611a4ab58a205b9b125ebd74c389a6b898"
	"github.com/nats-io/nats ea9585611a4ab58a205b9b125ebd74c389a6b898"
	"github.com/nats-io/nuid 289cccf02c178dc782430d534e3c1f5b72af807f"
	"github.com/nsqio/go-nsq eee57a3ac4174c55924125bb15eeeda8cffb6e6f"
	"github.com/opencontainers/runc 89ab7f2ccc1e45ddf6485eaa802c35dcf321dfc8"
	"github.com/opentracing-contrib/go-observer a52f2342449246d5bcc273e65cbdcfa5f7d6c63c"
	"github.com/opentracing/opentracing-go 06f47b42c792fef2796e9681353e1d908c417827"
	"github.com/openzipkin/zipkin-go-opentracing 1cafbdfde94fbf2b373534764e0863aa3bd0bf7b"
	"github.com/pierrec/lz4 5c9560bfa9ace2bf86080bf40d46b34ae44604df"
	"github.com/pierrec/xxHash 5a004441f897722c627870a981d02b29924215fa"
	"github.com/pkg/errors 645ef00459ed84a119197bfb8d8205042c6df63d"
	"github.com/pmezard/go-difflib 792786c7400a136282c1664665ae0a8db921c6c2"
	"github.com/prometheus/client_golang c317fb74746eac4fc65fe3909195f4cf67c5562a"
	"github.com/prometheus/client_model fa8ad6fec33561be4280a8f0514318c79d7f6cb6"
	"github.com/prometheus/common dd2f054febf4a6c00f2343686efb775948a8bff4"
	"github.com/prometheus/procfs 1878d9fbb537119d24b21ca07effd591627cd160"
	"github.com/rcrowley/go-metrics 1f30fe9094a513ce4c700b9a54458bbb0c96996c"
	"github.com/samuel/go-zookeeper 1d7be4effb13d2d908342d349d71a284a7542693"
	"github.com/satori/go.uuid 5bf94b69c6b68ee1b541973bb8e1144db23a194b"
	"github.com/shirou/gopsutil 384a55110aa5ae052eb93ea94940548c1e305a99"
	"github.com/shirou/w32 3c9377fc6748f222729a8270fe2775d149a249ad"
	"github.com/Shopify/sarama 3b1b38866a79f06deddf0487d5c27ba0697ccd65"
	"github.com/Sirupsen/logrus 61e43dc76f7ee59a82bdf3d71033dc12bea4c77d"
	"github.com/soniah/gosnmp 5ad50dc75ab389f8a1c9f8a67d3a1cd85f67ed15"
	"github.com/StackExchange/wmi f3e2bae1e0cb5aef83e319133eabfee30013a4a5"
	"github.com/streadway/amqp 63795daa9a446c920826655f26ba31c81c860fd6"
	"github.com/stretchr/objx 1a9d0bb9f541897e62256577b352fdbc1fb4fd94"
	"github.com/stretchr/testify 4d4bfba8f1d1027c4fdbe371823030df51419987"
	"github.com/vjeantet/grok d73e972b60935c7fec0b4ffbc904ed39ecaf7efe"
	"github.com/wvanbergen/kafka bc265fedb9ff5b5c5d3c0fdcef4a819b3523d3ee"
	"github.com/wvanbergen/kazoo-go 968957352185472eacb69215fa3dbfcfdbac1096"
	"github.com/yuin/gopher-lua 66c871e454fcf10251c61bf8eff02d0978cae75a"
	"github.com/zensqlmonitor/go-mssqldb ffe5510c6fa5e15e6d983210ab501c815b56b363"
	"golang.org/x/crypto dc137beb6cce2043eb6b5f223ab8bf51c32459f4 github.com/golang/crypto"
	"golang.org/x/net f2499483f923065a842d38eb4c7f1927e6fc6e6d github.com/golang/net"
	"golang.org/x/sys 739734461d1c916b6c72a63d7efda2b27edb369f github.com/golang/sys"
	"golang.org/x/text 506f9d5c962f284575e88337e7d9296d27e729d3 github.com/golang/text"
	"gopkg.in/asn1-ber.v1 4e86f4367175e39f69d9358a5f17b4dda270378d github.com/go-asn1-ber/asn1-ber"
	"gopkg.in/fatih/pool.v2 6e328e67893eb46323ad06f0e92cb9536babbabc github.com/fatih/pool"
	"gopkg.in/fsnotify.v1 a8a77c9133d2d6fd8334f3260d06f60e8d80a5fb github.com/fsnotify/fsnotify"
	"gopkg.in/gorethink/gorethink.v3 7ab832f7b65573104a555d84a27992ae9ea1f659 github.com/gorethink/gorethink"
	"gopkg.in/ldap.v2 8168ee085ee43257585e50c6441aadf54ecb2c9f github.com/go-ldap/ldap"
	"gopkg.in/mgo.v2 3f83fa5005286a7fe593b055f0d7771a7dce4655 github.com/go-mgo/mgo"
	"gopkg.in/olivere/elastic.v5 3113f9b9ad37509fe5f8a0e5e91c96fdc4435e26 github.com/olivere/elastic"
	"gopkg.in/tomb.v1 dd632973f1e7218eb1089048e0798ec9ae7dceb8 github.com/go-tomb/tomb"
	"gopkg.in/yaml.v2 4c78c975fe7c825c6d1466c42be594d1d6f3aba6 github.com/go-yaml/yaml"
)

inherit golang-build golang-vcs-snapshot systemd user

MY_PV="${PV/_rc/-rc.}"

DESCRIPTION="The plugin-driven server agent for collecting & reporting metrics."
HOMEPAGE="https://github.com/influxdata/telegraf"
SRC_URI="https://${EGO_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

pkg_setup() {
	enewgroup telegraf
	enewuser telegraf -1 -1 -1 telegraf
}

src_compile() {
	pushd "src/${EGO_PN}" || die
	pwd
	find -iname telegraf.go
	set -- env GOPATH="${S}" go build -i -v -work -x -o telegraf \
		cmd/telegraf/telegraf.go
	echo "$@"
	"$@" || die
	popd || die
}

src_install() {
	pushd "src/${EGO_PN}" || die
	dobin telegraf
	insinto /etc/telegraf
	doins etc/telegraf.conf
	keepdir /etc/telegraf/telegraf.d

	insinto /etc/logrotate.d
	doins etc/logrotate.d/telegraf

systemd_dounit scripts/telegraf.service
	newconfd "${FILESDIR}"/telegraf.confd telegraf
	newinitd "${FILESDIR}"/telegraf.rc telegraf

	dodoc -r docs/*

	keepdir /var/log/telegraf
	fowners telegraf:telegraf /var/log/telegraf
}
