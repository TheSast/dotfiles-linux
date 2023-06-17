# affix colons on either side of $PATH to simplify matching
case ":${PATH}:" in
    *:"/opt/bin":*)
        ;;
    *)
        # Prepending path in case a package-manager-installed software needs to be overridden
        export PATH="/opt/bin:$PATH"
        ;;
esac
