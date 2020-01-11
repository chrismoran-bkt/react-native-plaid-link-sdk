require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = package['name']
  s.version      = package['version']
  s.summary      = package['description']
  s.license      = package['license']

  s.authors      = package['author']
  s.homepage     = "https://plaid.com/docs/link/ios/"
  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/plaid/react-native-plaid-link-sdk.git", :tag => "v#{s.version}" }
  s.script_phase = { 
    name: 'Remove unnecessary files from framework',
    script: %(
set -ex
LINK_ROOT=${PODS_ROOT:+$PODS_ROOT/Plaid}
if [ -f "${LINK_ROOT:-$PROJECT_DIR}"/LinkKit.framework/prepare_for_distribution.sh ]; then
    echo "Removing '${LINK_ROOT:-$PROJECT_DIR}/LinkKit.framework/prepare_for_distribution.sh' because it is obsolete."
    rm -f "${LINK_ROOT:-$PROJECT_DIR}"/LinkKit.framework/prepare_for_distribution.sh
fi
),
    execution_position: :before_compile,
  }

  s.source_files  = "ios/*.{h,m}"

  s.dependency 'React'
  s.dependency 'Plaid'
end
